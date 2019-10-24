Imports System.IO
Imports iTextSharp.text
Imports iTextSharp.text.pdf

Public Class InvoicePrep
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            Dim sd As Date
            If IsDate(Session("InvoicePrep.StartDate")) Then
                sd = Session("InvoicePrep.StartDate")
            Else
                sd = Now.AddMonths(-1)
            End If


            Dim ed As Date
            If IsDate(Session("InvoicePrep.EndDate")) Then
                ed = Session("InvoicePrep.EndDate")
            Else
                ed = Now
            End If



            Me.StartDateTextBox.Text = sd.ToString("MM/dd/yyyy")
            Me.EndDateTextBox.Text = ed.ToString("MM/dd/yyyy")
        End If
    End Sub

    Protected Sub ExportButton_Click(sender As Object, e As EventArgs) Handles ExportButton.Click
        Dim t As New OrderReportDataSet.spInvoicePrepDataTable
        'Dim c As String = Nothing
        'c = Me.CustomerDropDownList.DataTextField
        Dim cid As Nullable(Of Integer) = Nothing
        If Me.CustomerDropDownList.SelectedIndex >= 0 Then
            cid = Me.CustomerDropDownList.SelectedValue
        End If
        Dim sd As Nullable(Of Date) = Nothing
        If IsDate(Me.StartDateTextBox.Text) Then
            sd = Date.Parse(Me.StartDateTextBox.Text)
        End If

        Dim ed As Nullable(Of Date) = Nothing
        If IsDate(Me.EndDateTextBox.Text) Then
            ed = Date.Parse(Me.EndDateTextBox.Text)
        End If
        Using ta As New OrderReportDataSetTableAdapters.spInvoicePrepTableAdapter
            ta.Fill(t, sd, ed, cid)
        End Using
        If t.Rows.Count > 0 Then
            '        Case "XML"

            ''this code will remove guid fields from the dataset
            'Dim i As Int32 = 0
            'While i < t.Columns.Count
            '    If t.Columns(i).DataType.ToString = "System.Guid" Then ' t.Rows(0).Item(i).ToString() Then
            '        t.Columns.RemoveAt(i)
            '        i = i - 1
            '    End If
            '    i = i + 1
            'End While

            Me.Response.Clear()
            Me.Response.ContentType = "application/octet-stream"
            Me.Response.AddHeader("Content-disposition", "attachment; filename=InvoicePrepReport" + Now.Ticks.ToString() + ".xml")
            t.WriteXml(Response.OutputStream, Data.XmlWriteMode.IgnoreSchema)
            Me.Response.End()
        End If

    End Sub

    Protected Sub QueueSqlDataSource_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles QueueSqlDataSource.Selecting

        If IsDate(Me.StartDateTextBox.Text) AndAlso IsDate(Me.EndDateTextBox.Text) AndAlso Me.CustomerDropDownList.SelectedIndex > -1 Then

            e.Command.Parameters("@StartDate").Value = Me.StartDateTextBox.Text
            e.Command.Parameters("@EndDate").Value = Me.EndDateTextBox.Text
            'e.Command.Parameters("@Customer").Value = "%SUNBELT%"
            e.Command.Parameters("@Customer").Value = Me.CustomerDropDownList.SelectedItem.Text
            'e.Command.Parameters("@CustomerCompanyID").Value = Me.StartDateTextBox.Text

        Else
            e.Cancel = True
        End If



    End Sub

    Private Sub SearchButton_Click(sender As Object, e As EventArgs) Handles SearchButton.Click
        Me.QueueRepeater.DataBind()
    End Sub

    Protected Sub SaveButton_Click(sender As Object, e As EventArgs)
        Dim soid As Integer = Integer.Parse(CType(sender, Button).CommandArgument)
        Dim PO As String = CType(CType(CType(sender, Button).Parent, Control).FindControl("POTextBox"), TextBox).Text
        Dim BOL As String = CType(CType(CType(sender, Button).Parent, Control).FindControl("BOLTextBox"), TextBox).Text

        Dim con As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ToString)
        Try
            Using cmd As New SqlClient.SqlCommand("ShippingOrderQueue_Update", con)
                With cmd
                    .CommandType = CommandType.StoredProcedure
                    .Connection.Open()
                    .Parameters.AddWithValue("@ShippingOrderID", soid)
                    .Parameters.AddWithValue("@PO", PO)
                    .Parameters.AddWithValue("@BOL", BOL)
                    .ExecuteScalar()
                End With
            End Using
        Catch ex As Exception
            Throw ex
        Finally
            con.Close()
        End Try



    End Sub

    Protected Sub ScanDocButton_Click(sender As Object, e As EventArgs)
        Session("InvoicePrep.StartDate") = Me.StartDateTextBox.Text
        Session("InvoicePrep.EndDate") = Me.EndDateTextBox.Text

        Response.Redirect("~/BOLScanner.aspx?soid=" + CType(sender, Button).CommandArgument)
    End Sub

    Protected Sub CreateBatch_Click(sender As Object, e As EventArgs)
        For Each r As RepeaterItem In QueueRepeater.Items
            If r.ItemType = ListItemType.Item AndAlso CType(r.FindControl("BatchCheckBox"), CheckBox).Checked Then
                'todo: do something!
            End If
        Next
    End Sub

    Private Sub QueueRepeater_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles QueueRepeater.ItemDataBound

        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            If CType(e.Item.FindControl("BackupDocPathHiddenField"), HiddenField).Value = "" Then
                CType(e.Item.FindControl("EnabledViewButton"), Button).Enabled = False
                'CType(e.Item.FindControl("DisabledViewButton"), HtmlControl).Visible = True
            Else
                CType(e.Item.FindControl("EnabledViewButton"), Button).Enabled = True
                'CType(e.Item.FindControl("DisabledViewButton"), HtmlControl).Visible = False
            End If
        End If
    End Sub



    'Private Function UpdateInvoiceDate(InvoiceBatch As String, InvoiceDate As DateTime) As String
    '    Dim s As String = ""
    '    Dim con As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)

    '    Try
    '        Using cmd As New SqlClient.SqlCommand("[InvoiceBatchSetDate]", con)
    '            With cmd
    '                .Connection.Open()
    '                .CommandType = CommandType.StoredProcedure
    '                .Parameters.AddWithValue("@InvoiceDate", InvoiceDate)
    '                .Parameters.AddWithValue("@invoiceBatch", InvoiceBatch)
    '                s = .ExecuteScalar
    '            End With
    '        End Using

    '    Catch ex As Exception
    '        s = "Error"
    '    Finally
    '        con.Close()
    '    End Try
    '    Return s
    'End Function



    Public Shared Function ConcatenatePdfs(ByVal documents As IEnumerable(Of Byte())) As Byte()
        Using ms = New MemoryStream()
            Dim outputDocument = New Document()
            Dim writer = New PdfCopy(outputDocument, ms)
            outputDocument.Open()

            For Each doc In documents
                Dim reader = New PdfReader(doc)

                For i = 1 To reader.NumberOfPages
                    writer.AddPage(writer.GetImportedPage(reader, i))
                Next

                writer.FreeReader(reader)
                reader.Close()
            Next

            writer.Close()
            outputDocument.Close()
            Dim allPagesContent = ms.GetBuffer()
            ms.Flush()
            Return allPagesContent
        End Using
    End Function

    Protected Sub BatchOfPORsButton_Click(sender As Object, e As EventArgs)
        Dim documents As List(Of Byte()) = New List(Of Byte())

        For Each r As RepeaterItem In QueueRepeater.Items
            If r.ItemType = ListItemType.Item Or r.ItemType = ListItemType.AlternatingItem Then
                If CType(r.FindControl("SelectedItemCheckBox"), CheckBox).Checked = True Then
                    Dim soid As Integer = CType(r.FindControl("ShippingOrderIDHiddenField"), HiddenField).Value

                    MarkPORAsPrinted(soid)


                    Dim dt As New PORequestDataSet.PORequestSheetDataTable
                    Using ta As New PORequestDataSetTableAdapters.PORequestSheetTableAdapter
                        ta.Fill(dt, soid)
                    End Using
                    If dt.Rows.Count = 1 Then
                        Dim viewer As New Microsoft.Reporting.WebForms.ReportViewer()

                        'Create Report Data Source
                        Dim rptDataSource As New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt.DefaultView)

                        viewer.LocalReport.DataSources.Add(rptDataSource)
                        Dim fn As String = ""

                        viewer.LocalReport.ReportPath = Context.Server.MapPath("~/PurchaseOrderRequestReport.rdlc")
                        'fn = "PurchaseOrderRequest" + Convert.ToString(dt.Rows(0)("OrderNumber"))



                        'Export to PDF
                        Dim pdfContent As Byte() = viewer.LocalReport.Render("PDF", Nothing, Nothing, Nothing, Nothing, Nothing, Nothing)

                        documents.Add(pdfContent)

                    End If



                End If
            End If
        Next

        If documents.Count > 0 Then

            'Return PDF
            Me.Response.Clear()
            Me.Response.ContentType = "application/pdf"
            Me.Response.AddHeader("Content-disposition", "attachment; filename=POR-" + Now.ToString("YYYY-MM-DD") + ".pdf")
            Me.Response.BinaryWrite(ConcatenatePdfs(documents))
            Me.Response.End()
        End If
    End Sub

    Sub MarkPORAsPrinted(soid As Integer)
        Dim con As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Try
            Dim cmd As New SqlClient.SqlCommand
            With cmd
                .Connection = con
                .CommandText = "update shippingorder set PORequested = '" + Now.ToShortDateString + "' where shippingorderid = " + soid.ToString()
                .CommandType = CommandType.Text
                .Connection.Open()
                .ExecuteNonQuery()
            End With
        Catch ex As Exception
            '            Me.CopyMessageLabel.text = ex.ToString
        Finally
            con.Close()
        End Try
    End Sub




    Protected Sub BatchOfInvoicesButton_Click(sender As Object, e As EventArgs)
        Dim documents As List(Of Byte()) = New List(Of Byte())

        For Each r As RepeaterItem In QueueRepeater.Items
            If r.ItemType = ListItemType.Item Or r.ItemType = ListItemType.AlternatingItem Then
                If CType(r.FindControl("SelectedItemCheckBox"), CheckBox).Checked = True Then
                    Dim soid As Integer = CType(r.FindControl("ShippingOrderIDHiddenField"), HiddenField).Value




                    Dim dt As New PORequestDataSet.PORequestSheetDataTable
                    Using ta As New PORequestDataSetTableAdapters.PORequestSheetTableAdapter
                        ta.Fill(dt, soid)
                    End Using
                    If dt.Rows.Count = 1 Then
                        Dim viewer As New Microsoft.Reporting.WebForms.ReportViewer()

                        'Create Report Data Source
                        Dim rptDataSource As New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt.DefaultView)

                        viewer.LocalReport.DataSources.Add(rptDataSource)
                        Dim fn As String = ""

                        viewer.LocalReport.ReportPath = Context.Server.MapPath("~/Invoice.rdlc")
                        'fn = "PurchaseOrderRequest" + Convert.ToString(dt.Rows(0)("OrderNumber"))



                        'Export to PDF
                        Dim pdfContent As Byte() = viewer.LocalReport.Render("PDF", Nothing, Nothing, Nothing, Nothing, Nothing, Nothing)

                        documents.Add(pdfContent)

                    End If



                End If
            End If
        Next

        If documents.Count > 0 Then

            'Return PDF
            Me.Response.Clear()
            Me.Response.ContentType = "application/pdf"
            Me.Response.AddHeader("Content-disposition", "attachment; filename=Invoice-" + Now.ToString("YYYY-MM-DD") + ".pdf")
            Me.Response.BinaryWrite(ConcatenatePdfs(documents))
            Me.Response.End()
        End If
    End Sub
End Class