Imports System.IO

Public Class Billing
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("cl.user") <> True Then Response.Redirect("~/Account/Login.aspx")
    End Sub

    Private Sub ExportToQuickBooksButton_Click(sender As Object, e As EventArgs) Handles ExportToQuickBooksButton.Click

        'Dim fs As String = ""
        'Using sr As New StreamReader(MapPath("~/Content/SampleInvoice.iif"))
        '    fs = sr.ReadToEnd
        'End Using

        'Make a new batch number
        Dim InvoiceBatch As String = Now.ToString("yyyyMMddhhmmss")

        'set the batch
        For Each r As GridViewRow In Me.OrdersGridView.Rows
            If CType(r.FindControl("BillCheckBox"), CheckBox).Checked Then
                AddToBatch(Me.OrdersGridView.DataKeys(r.RowIndex)(0), InvoiceBatch)
            End If
        Next

        'get the file
        'Dim fs As String = iif(InvoiceBatch)

        'update invoice date
        Me.UpdateInvoiceDate(InvoiceBatch, Now)


        ''sent to browser
        'Response.Clear()
        'Response.ContentType = "text/plain"
        'Response.AddHeader("Content-disposition", "attachment; filename=clQuickBooks" & Now.ToShortDateString.Replace("/", "") & ".iif")
        'Response.Write(fs)
        'Response.End()

        Me.ExportToQuickBooksButton.Enabled = False
        Me.OrdersGridView.DataBind()
        Me.InvoiceBatchDropDownList.DataBind()

    End Sub

    Protected Sub SearchButton_Click(sender As Object, e As EventArgs) Handles SearchButton.Click
        Me.OrdersGridView.DataBind()
    End Sub
    Dim _NetTotal As Decimal

    Private Sub OrdersGridView_DataBound(sender As Object, e As EventArgs) Handles OrdersGridView.DataBound
        Try
            CType(Me.OrdersGridView.FooterRow.FindControl("NetTotalLabel"), Label).Text = String.Format("{0:c}", _NetTotal)
        Catch ex As Exception
            'nothing
        End Try
    End Sub

    Protected Sub OrdersGridView_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles OrdersGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            _NetTotal += CType(e.Row.FindControl("NetLabel"), Label).Text
            Me.ExportToQuickBooksButton.Enabled = True
        End If
    End Sub

    Private Function AddToBatch(ShippingOrderID As Integer, InvoiceBatch As String) As String
        Dim s As String = ""
        Dim con As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        Try
            Using cmd As New SqlClient.SqlCommand("[InvoiceBatchUpdate]", con)
                With cmd
                    .Connection.Open()
                    .CommandType = CommandType.StoredProcedure
                    .Parameters.AddWithValue("@ShippingOrderID", ShippingOrderID)
                    .Parameters.AddWithValue("@InvoiceBatch", InvoiceBatch)
                    s = .ExecuteScalar
                End With
            End Using
            s = "Okay"
        Catch ex As Exception
            s = "Error"
        Finally
            con.Close()
        End Try
        Return s
    End Function


    Private Function iif(InvoiceBatch As String) As String
        Dim s As String = ""

        Try
            'Dim InvoiceDate As DateTime = Now()
            Dim LineItemNumber As Integer = 1

            Dim t As New ShippingOrderDataSet.InvoiceBatchDataTable
            Using ta As New ShippingOrderDataSetTableAdapters.InvoiceBatchTableAdapter
                ta.Fill(t, InvoiceBatch)
            End Using
            If t.Rows.Count() > 0 Then
                Dim InvoiceDate As DateTime
                Dim sbACCNT, sbCUST, sbINVITEM, sbTRNS, sbCOMPLETE As New StringBuilder

                For Each r As ShippingOrderDataSet.InvoiceBatchRow In t.Rows
                    InvoiceDate = r.InvoiceDate
                    'if we don't already have this customer, add them
                    If sbCUST.ToString.Contains(r.CustomerCompanyName) = False Then
                        'sbCUST.AppendLine("CUST	" & r.CustomerCompanyName.ToString)
                        'sbCUST.AppendLine("CUST	" & r.CustomerCompanyName & "		" & r.CustomerBillingAddress1 & "	" & r.CustomerBillingAddress2 & "	" & r.CustomerBillingCity & ", " & r.CustomerBillilngState & " " & r.CustomerBillingPostalCode & "	" & "" & "	" & "" & "											Y	Tax																												0				N	0	")

                        Dim c As String = "!CUST" & vbTab
                        c += r.CustomerCompanyName & vbTab
                        c += r.CustomerCompanyName & vbTab
                        c += r.CustomerBillingAddress1 & vbTab
                        If r.CustomerBillingAddress2 = "" Then
                            c += r.CustomerBillingCity & ", " & r.CustomerBillilngState & " " & r.CustomerBillingPostalCode & vbTab
                            c += "" & vbTab
                        Else
                            c += r.CustomerBillingAddress2 & vbTab
                            c += r.CustomerBillingCity & ", " & r.CustomerBillilngState & " " & r.CustomerBillingPostalCode & vbTab
                        End If
                        c += "" & vbTab
                        c += r.CustomerCompanyName
                        sbCUST.AppendLine(c)
                        c = ""

                    End If

                    With sbTRNS
                        '--------JEM 5.13.2008
                        '.AppendLine("TRNS		INVOICE	" & InvoiceDate.ToShortDateString & "	Accounts Receivable	" & r.CustomerCompanyName.ToString & "		" & Math.Round(r.CustomerBillAmount, 2).ToString & r.OrderNumber.ToString & "		N	N	N")
                        '.AppendLine("SPL		INVOICE	" & InvoiceDate.ToShortDateString & "	Fees			-" & Math.Round(r.CustomerBillAmount, 2).ToString & vbTab & r.OrderNumber.ToString & "	Fees	N			Fees	N")

                        Dim invoicetotal As Decimal = 0
                        invoicetotal = r.CustomerBillAmount
                        If Not r.IsExtraCharge1AmountNull Then invoicetotal += r.ExtraCharge1Amount

                        Dim lidesc As String = ""

                        If Not r.IsPONull Then
                            lidesc += "PO: " & r.PO.Replace(",", ";") & "\n"
                        End If
                        If Not r.IsBOLNull Then
                            lidesc += "BOL: " & r.BOL.Replace(",", ";") & "\n"
                        End If

                        lidesc += "Commodity: " & r.a1CommodityType.Replace("""", "''") & "\n"

                        'lidesc += "Pickup: " & r.Location1CompanyName & "\n" ' "code for pickup location" & "\n"

                        If Not r.Isa1ActivityTypeNull AndAlso r.a1ActivityType <> "" Then

                            lidesc += r.a1ActivityType + ": "

                            If Not r.IsLocation1CompanyNameNull Then
                                lidesc += r.Location1CompanyName
                            End If

                            If Not r.Isa1CityNull And Not r.Isa1StateNull Then
                                lidesc += " - " + r.a1City + ", " + r.a1State
                            End If

                            'Try
                            '    If Not r.Isa1ActivityDateNull Then
                            '        lidesc += " (" + Date.Parse(r.a1ActivityDate).ToShortDateString + ")"
                            '    End If

                            'Catch ex As Exception
                            '    '
                            'End Try

                            lidesc += "\n"

                        End If

                        If Not r.Isa2ActivityTypeNull AndAlso r.a2ActivityType <> "" Then

                            lidesc += r.a2ActivityType + ": "

                            If Not r.IsLocation2CompanyNameNull Then
                                lidesc += r.Location2CompanyName
                            End If

                            If Not r.Isa2CityNull And Not r.Isa2StateNull Then
                                lidesc += " - " + r.a2City + ", " + r.a2State
                            End If


                            'Try
                            '    If Not r.Isa2ActivityDateNull Then
                            '        lidesc += " (" + Date.Parse(r.a2ActivityDate).ToShortDateString + ")"
                            '    End If

                            'Catch ex As Exception
                            '    '
                            'End Try

                            lidesc += "\n"

                        End If

                        If Not r.Isa3ActivityTypeNull AndAlso r.a3ActivityType <> "" Then

                            lidesc += r.a3ActivityType + ": "

                            If Not r.IsLocation3CompanyNameNull Then
                                lidesc += r.Location3CompanyName
                            End If

                            If Not r.Isa3CityNull And Not r.Isa3StateNull Then
                                lidesc += " - " + r.a3City + ", " + r.a3State
                            End If


                            'Try
                            '    If Not r.Isa3ActivityDateNull Then
                            '        lidesc += " (" + Date.Parse(r.a3ActivityDate).ToShortDateString + ")"
                            '    End If
                            'Catch ex As Exception
                            '    '
                            'End Try

                            lidesc += "\n"

                        End If

                        If Not r.Isa4ActivityTypeNull AndAlso r.a4ActivityType <> "" Then

                            lidesc += r.a4ActivityType + ": "

                            If Not r.IsLocation4CompanyNameNull Then
                                lidesc += r.Location4CompanyName
                            End If

                            If Not r.Isa4CityNull And Not r.Isa4StateNull Then
                                lidesc += " - " + r.a4City + ", " + r.a4State
                            End If


                            'Try
                            '    If Not r.Isa4ActivityDateNull Then
                            '        lidesc += " (" + Date.Parse(r.a4ActivityDate).ToShortDateString + ")"
                            '    End If

                            'Catch ex As Exception
                            '    '
                            'End Try

                            lidesc += "\n"

                        End If


                        'lidesc += "Delivery: " & "code for delivery location" & "\n"
                        'lidesc += "Pickup Date: " & r.a1ActivityDate

                        Try
                            lidesc += Date.Parse(r.a1ActivityDate).ToShortDateString + "\n"
                        Catch ex As Exception
                            '
                        End Try

                        If Not r.IsLoadTypeNull Then lidesc += r.LoadType.Replace("""", "''")


                        .AppendLine("TRNS	" & LineItemNumber & "	INVOICE	" & r.InvoiceDate.ToShortDateString & "	Accounts Receivable	" & r.CustomerCompanyName & "	" & Math.Round(invoicetotal, 2).ToString & "	" & r.OrderNumber.ToString & "	N	Y	N	" & r.CustomerCompanyName & "	" & r.CustomerCompanyName & "	" & r.CustomerBillingAddress1 & " " & r.CustomerBillingAddress2 & "	" & r.CustomerBillingCity & ", " & r.CustomerBillilngState & " " & r.CustomerBillingPostalCode & "	" & "	" & "" & "	" & "" & "	" & "" & "	" & r.InvoiceDate.ToShortDateString)

                        '.AppendLine("!TRNS	    TRNSID	            TRNSTYPE	DATE	                            ACCNT	                NAME	                        AMOUNT	                                        DOCNUM	                    CLEAR	TOPRINT	ISTAXABLE	NAME	            ADDR1	                        ADDR2	                                                            ADDR3	                                                                                            ADDR4	        ADDR5	    DUEDATE	        SHIPDATE")

                        LineItemNumber += 1
                        .AppendLine("SPL	" & LineItemNumber & "	INVOICE	" & r.InvoiceDate.ToShortDateString & "	Gross Trucking Income			-" & Math.Round(r.CustomerBillAmount, 2).ToString & "		" & lidesc & "	N	-1	" & Math.Round(r.CustomerBillAmount, 2).ToString & "	FEES		N	N	NOTHING																											")
                        LineItemNumber += 1

                        If Not r.IsExtraCharge1AmountNull AndAlso r.ExtraCharge1Amount > 0 Then
                            Dim extrachargedescription As String = ""
                            If Not r.IsExtraCharge1DescriptionNull Then
                                extrachargedescription = r.ExtraCharge1Description
                            End If
                            .AppendLine("SPL	" & LineItemNumber & "	INVOICE	" & r.InvoiceDate.ToShortDateString & "	Gross Trucking Income			-" & Math.Round(r.ExtraCharge1Amount, 2).ToString & "		" & extrachargedescription & "	N		" & Math.Round(r.ExtraCharge1Amount, 2).ToString & "	FEES		N	N	NOTHING																											")
                            LineItemNumber += 1
                        End If



                        .AppendLine("SPL	" & LineItemNumber & "	INVOICE	" & r.InvoiceDate.ToShortDateString & "	Sales Tax Payable	TaxAgencyVendor		-0.00	" & r.OrderNumber.ToString & "		N		0.00%	Sales Tax		N	N	NOTHING							AUTOSTAX																				")
                        LineItemNumber += 1



                        .AppendLine("ENDTRNS")
                    End With

                Next


                With sbCOMPLETE

                    'accounts header
                    '.AppendLine("!ACCNT	NAME	ACCNTTYPE	DESC	ACCNUM	EXTRA")
                    .AppendLine("!ACCNT	NAME	REFNUM	TIMESTAMP	ACCNTTYPE	OBAMOUNT	DESC	ACCNUM	SCD	BANKNUM	EXTRA	HIDDEN	DELCOUNT	USEID")

                    'Accounts
                    '.AppendLine("ACCNT	Accounts Receivable	AR")
                    '.AppendLine("ACCNT	FEES	INC")
                    .AppendLine("ACCNT	Accounts Receivable	42	1369845884	AR		Unpaid Or unapplied customer invoices And credits	11000	1865			N	0	N")
                    .AppendLine("ACCNT	Gross Trucking Income	10	1364496854	INC		Gross receipts from trucking services	44600	0			N	0	N")
                    .AppendLine("ACCNT	Sales Tax Payable	4	1154536741	OCLIAB				0		SALESTAX	N	0	N																																													")



                    'invoice item header
                    '.AppendLine("!INVITEM	NAME	INVITEMTYPE	DESC	PURCHASEDESC	ACCNT	ASSETACCNT	COGSACCNT	PRICE	COST	TAXABLE	PAYMETH	TAXVEND	TAXDIST	PREFVEND	REORDERPOINT	EXTRA")
                    .AppendLine("!INVITEM	NAME	REFNUM	TIMESTAMP	INVITEMTYPE	DESC	PURCHASEDESC	ACCNT	ASSETACCNT	COGSACCNT	QNTY	QNTY	PRICE	COST	TAXABLE	SALESTAXCODE	PAYMETH	TAXVEND	PREFVEND	REORDERPOINT	EXTRA	CUSTFLD1	CUSTFLD2	CUSTFLD3	CUSTFLD4	CUSTFLD5	DEP_TYPE	ISPASSEDTHRU	HIDDEN	DELCOUNT	USEID	ISNEW	PO_NUM	SERIALNUM	WARRANTY	LOCATION	VENDOR	ASSETDESC	SALEDATE	SALEEXPENSE	NOTES	ASSETNUM	COSTBASIS	ACCUMDEPR	UNRECBASIS	PURCHASEDATE")

                    'invoice items
                    '.AppendLine("INVITEM	Fees Charge	SERV	Fees	Fees	Fees			0	0	Y")
                    .AppendLine("INVITEM	FEES	1	1370435236	OTHC			Gross Trucking Income					0.00	0.00	N												0	N	N	0	N	Y								0.00			0.00	0.00	0.00	")
                    .AppendLine("INVITEM	Sales Tax	1	1154536741	COMPTAX			Sales Tax Payable				0	5.00%	0	N			TaxAgencyVendor									0	N	N	0	N	Y								0			0	0	0														")

                    'vendor
                    .AppendLine("VTYPE	Tax agency	2	1154536605	N																																								")
                    .AppendLine("!VEND	NAME	REFNUM	TIMESTAMP	PRINTAS	ADDR1	ADDR2	ADDR3	ADDR4	ADDR5	VTYPE	CONT1	CONT2	PHONE1	PHONE2	FAXNUM	EMAIL	NOTE	TAXID	LIMIT	TERMS	NOTEPAD	SALUTATION	COMPANYNAME	FIRSTNAME	MIDINIT	LASTNAME	CUSTFLD1	CUSTFLD2	CUSTFLD3	CUSTFLD4	CUSTFLD5	CUSTFLD6	CUSTFLD7	CUSTFLD8	CUSTFLD9	CUSTFLD10	CUSTFLD11	CUSTFLD12	CUSTFLD13	CUSTFLD14	CUSTFLD15	1099	HIDDEN	DELCOUNT")
                    .AppendLine("VEND	TaxAgencyVendor	2	1154536740		TaxAgencyVendor																																					N	N	0")


                    'customer header
                    '.AppendLine("!CUST	NAME	BADDR1	BADDR2	BADDR3	BADDR4	BADDR5	SADDR1	SADDR2	SADDR3	SADDR4	SADDR5	PHONE1	PHONE2	FAXNUM	EMAIL	NOTE	CONT1	CONT2	CType	TERMS	TAXABLE	LIMIT	RESALENUM	REP	TAXITEM	NOTEPAD	SALUTATION	COMPANYNAME	FIRSTNAME	MIDINIT	LASTNAME")
                    '.AppendLine("!CUST	NAME	REFNUM	TIMESTAMP	BADDR1	BADDR2	BADDR3	BADDR4	BADDR5	SADDR1	SADDR2	SADDR3	SADDR4	SADDR5	PHONE1	PHONE2	FAXNUM	EMAIL	NOTE	CONT1	CONT2	CType	TERMS	TAXABLE	SALESTAXCODE	LIMIT	RESALENUM	REP	TAXITEM	NOTEPAD	SALUTATION	COMPANYNAME	FIRSTNAME	MIDINIT	LASTNAME	CUSTFLD1	CUSTFLD2	CUSTFLD3	CUSTFLD4	CUSTFLD5	CUSTFLD6	CUSTFLD7	CUSTFLD8	CUSTFLD9	CUSTFLD10	CUSTFLD11	CUSTFLD12	CUSTFLD13	CUSTFLD14	CUSTFLD15	JOBDESC	JOBTYPE	JOBSTATUS	JOBSTART	JOBPROJEND	JOBEND	HIDDEN	DELCOUNT	PRICELEVEL")
                    .AppendLine("!CUST	NAME	BADDR1	BADDR2	BADDR3	BADDR4	BADDR5	COMPANYNAME")

                    'customers
                    .Append(sbCUST.ToString)

                    'transaction headers
                    '.AppendLine("!TRNS	TRNSID	TRNSTYPE	DATE	ACCNT	NAME	CLASS	AMOUNT	DOCNUM	MEMO	CLEAR	TOPRINT	NAMEISTAXABLE	ADDR1	ADDR3	TERMS")
                    '.AppendLine("!SPL	SPLID	TRNSTYPE	DATE	ACCNT	NAME	CLASS	AMOUNT	DOCNUM	MEMO	CLEAR	QNTY	PRICE	INVITEM	TAXABLE	EXTRA")

                    '.AppendLine("!TRNS	TRNSID	TRNSTYPE	DATE	ACCNT	NAME	CLASS	AMOUNT	DOCNUM	MEMO	CLEAR	TOPRINT NAME    ISTAXABLE	ADDR1	ADDR2	ADDR3	ADDR4	ADDR5	DUEDATE	TERMS	PAID	PAYMETH SHIPVIA	SHIPDATE	OTHER1	REP	FOB	PONUM	INVTITLE	INVMEMO	SADDR1	SADDR2	SADDR3	SADDR4	SADDR5	PAYITEM	YEARTODATE	WAGEBASE	EXTRA	TOSEND	ISAJE				")
                    .AppendLine("!TRNS	TRNSID	TRNSTYPE	DATE	ACCNT	NAME	AMOUNT	DOCNUM	CLEAR	TOPRINT	ISTAXABLE	NAME	ADDR1	ADDR2	ADDR3	ADDR4	ADDR5	DUEDATE	SHIPDATE")


                    .AppendLine("!SPL	SPLID	TRNSTYPE	DATE	ACCNT	NAME	CLASS	AMOUNT	DOCNUM	MEMO	CLEAR	QNTY	PRICE	INVITEM	PAYMETH	TAXABLE	VALADJ	REIMBEXP	SERVICEDATE	OTHER2	OTHER3	PAYITEM	YEARTODATE	WAGEBASE	EXTRA																				")
                    .AppendLine("!ENDTRNS")

                    'transactions
                    .Append(sbTRNS.ToString)
                End With

                s = sbCOMPLETE.ToString.ToUpper.Replace("\N", "\n")

            Else
                s = "Error - No Data"
            End If
        Catch ex As Exception
            s = "Error - " & ex.ToString
        End Try

        Return s

    End Function

    Private Function UpdateInvoiceDate(InvoiceBatch As String, InvoiceDate As DateTime) As String
        Dim s As String = ""
        Dim con As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

        Try
            Using cmd As New SqlClient.SqlCommand("[InvoiceBatchSetDate]", con)
                With cmd
                    .Connection.Open()
                    .CommandType = CommandType.StoredProcedure
                    .Parameters.AddWithValue("@InvoiceDate", InvoiceDate)
                    .Parameters.AddWithValue("@invoiceBatch", InvoiceBatch)
                    s = .ExecuteScalar
                End With
            End Using

        Catch ex As Exception
            s = "Error"
        Finally
            con.Close()
        End Try
        Return s
    End Function

    Protected Sub ExportBatchButton_Click(sender As Object, e As EventArgs) Handles ExportBatchButton.Click
        'get the file
        Dim fs As String = iif(Me.InvoiceBatchDropDownList.SelectedValue)

        'update invoice date
        Me.UpdateInvoiceDate(Me.InvoiceBatchDropDownList.SelectedValue, Now)


        'sent to browser
        Response.Clear()
        Response.ContentType = "text/plain"
        Response.AddHeader("Content-disposition", "attachment; filename=clQuickBooks" & Me.InvoiceBatchDropDownList.SelectedValue & ".iif")
        Response.Write(fs)
        Response.End()
    End Sub

    Protected Sub InvoiceBatchGridView_DataBound(sender As Object, e As EventArgs) Handles InvoiceBatchGridView.DataBound
        Try
            CType(Me.InvoiceBatchGridView.FooterRow.FindControl("NetTotalLabel"), Label).Text = String.Format("{0:c}", _BatchNetTotal)
        Catch ex As Exception
            'nothing
        End Try
    End Sub

    Public _BatchNetTotal As Decimal
    Protected Sub InvoiceBatchGridView_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles InvoiceBatchGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            _BatchNetTotal += CType(e.Row.FindControl("NetLabel"), Label).Text
        End If
    End Sub

    Private Sub ShippingOrdersSqlDataSource_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles ShippingOrdersSqlDataSource.Selecting
        e.Command.Parameters("@CompanyName").Value = "%" + e.Command.Parameters("@CompanyName").Value + "%"
    End Sub

    Private Sub ExportSunbeltBatchButton_Click(sender As Object, e As EventArgs) Handles ExportSunbeltBatchButton.Click

        Dim dt As New InvoiceBatchSunbeltDataSet.InvoiceBatchGetSunbeltDataDataTable
        Using ta As New InvoiceBatchSunbeltDataSetTableAdapters.InvoiceBatchGetSunbeltDataTableAdapter
            ta.Fill(dt, InvoiceBatchDropDownList.SelectedValue)
        End Using

        Dim fs As Byte() = csvBytesWriter(dt)

        'sent to browser
        Response.Clear()
        Response.ContentType = "text/plain"
        Response.AddHeader("Content-disposition", "attachment; filename=Citation-Sunbelt-" & Me.InvoiceBatchDropDownList.SelectedValue & ".csv")
        Response.BinaryWrite(fs)
        Response.End()

    End Sub

    Function csvBytesWriter(ByRef dTable As DataTable) As Byte()

        '--------Columns Name--------------------------------------------------------------------------- 

        Dim sb As StringBuilder = New StringBuilder()
        Dim intClmn As Integer = dTable.Columns.Count

        Dim i As Integer = 0
        For i = 0 To intClmn - 1 Step i + 1
            sb.Append("""" + dTable.Columns(i).ColumnName.ToString() + """")
            If i = intClmn - 1 Then
                sb.Append(" ")
            Else
                sb.Append(",")
            End If
        Next
        sb.Append(vbNewLine)

        '--------Data By  Columns--------------------------------------------------------------------------- 

        Dim row As DataRow
        For Each row In dTable.Rows

            Dim ir As Integer = 0
            For ir = 0 To intClmn - 1 Step ir + 1
                'sb.Append("""" + row(ir).ToString().Replace("'", "").Replace(",", "").Replace("""", """""") + """")
                sb.Append(row(ir).ToString().Replace("'", "").Replace(",", "").Replace("""", ""))
                If ir = intClmn - 1 Then
                    sb.Append(" ")
                Else
                    sb.Append(",")
                End If

            Next
            sb.Append(vbNewLine)
        Next

        Return System.Text.Encoding.UTF8.GetBytes(sb.ToString)

    End Function

End Class

