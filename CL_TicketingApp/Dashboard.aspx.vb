Imports System.Data.SqlClient

Public Class Dashboard
    Inherits System.Web.UI.Page



    <System.Web.Script.Services.ScriptMethod(),
System.Web.Services.WebMethod()>
    Public Shared Function SearchLocations(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
        Dim conn As SqlConnection = New SqlConnection
        conn.ConnectionString = ConfigurationManager _
             .ConnectionStrings("DefaultConnection").ConnectionString
        Dim cmd As SqlCommand = New SqlCommand
        cmd.CommandText = "select id, companyname + ' (' + isnull(sCity,'Unknown City') + ', ' + isnull(sState,'Unknown State') + ')' as CompanyName from company where isnull(disabled,0) = 0 and isnull(vendor,0) = 0 and isnull(customer,0) = 0 and companyname + '/' + isnull(sCity,'Unknown City') + '/' + isnull(sState,'Unknown State') like '%' + @SearchText + '%' order by CompanyName"
        cmd.Parameters.AddWithValue("@SearchText", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim c As List(Of String) = New List(Of String)
        Dim sdr As SqlDataReader = cmd.ExecuteReader
        While sdr.Read
            Dim item As String = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("CompanyName").ToString, sdr("id").ToString)
            c.Add(item)
            'c.Add(sdr("CompanyName").ToString)
        End While
        conn.Close()
        Return c
    End Function




    Private Function GetNextOrderNumber() As Integer
        Dim i As Integer
        Dim con As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Try
            Dim cmd As New SqlCommand
            With cmd
                .Connection = con
                .Connection.Open()
                .CommandType = CommandType.Text
                'If ShippingOrderID > 0 Then
                .CommandText = "select top 1 ordernumber from shippingorder order by ordernumber desc"
                'Else
                '.CommandText = "select top 1 ordernumber from shippingorder where ordernumber = " + ShippingOrderID.ToString

                'End If
                i = .ExecuteScalar
            End With
        Catch ex As Exception
            Throw ex
        Finally
            con.Close()
        End Try
        Return i + 1
    End Function


    Private Sub OrdersSqlDataSource_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles OrdersSqlDataSource.Inserting



        Dim sb As New StringBuilder

        If Me.NotesTextBox.Text <> "" Then
            sb.AppendLine(Me.NotesTextBox.Text)
            sb.AppendLine()
        End If
        sb.AppendLine("*DRIVER MUST CALL 985-641-8233 FOR PICK UP NUMBERS & LOAD DETAIL!!!*")
        sb.AppendLine()
        sb.AppendLine("*CHAINS AND BINDERS ARE REQUIRED FOR LOADING*")
        sb.AppendLine()
        sb.AppendLine("*ALL DRIVERS MUST HAVE PROPER PPE WHEN LOADING/UNLOADING (HARD HAT, SAFETY GLASSES, STEEL TOE BOOTS) – FAILURE TO COMPLY WITH PPE REQUIREMENTS WILL RESULT IN A $250.00 RATE DEDUCTION FROM RATE CONFIRMATION*")
        sb.AppendLine()
        sb.AppendLine("*ANY CHANGES TO PICK UP OR DELIVERY MUST BE VERIFIED THROUGH THIS OFFICE*")
        sb.AppendLine()
        sb.AppendLine("*SIGNED BILL OF LADING IS REQUIRED FOR PAYMENT*")
        sb.AppendLine()
        sb.AppendLine("All units must remain chained, except for the unit being loaded or unloaded at the specific time at the pickup or delivery.  This is to avoid any equipment on the trailer from shifting, rolling, sliding or falling from the deck of the trailer and causing harm to the unit / units and the person / persons loading or unloading the equipment.")
        sb.AppendLine()
        sb.AppendLine("*ALL SHIPMENTS ARE TIME CRITICAL.  FAILURE TO MEET DELIVERY TIME LISTED ON RATE CONFIRMATION MAY RESULT IN A RATE DEDUCTION!!  WE MUST BE NOTIFIED    IMMEDIATELY IF ANY ISSUES OCCUR TO DELAY ON TIME PICK UP OR DELIVERY.  WE ARE AVAILABLE 24/7 AT (985)-641-8233*")
        sb.AppendLine()
        sb.AppendLine("*ALL SHIPMENTS ARE CONSIDERED DEDICATED UNLESS NOTED OTHERWISE ON RATE CONFIRMATION.")




        'e.Command.Parameters("@ShippingOrderID").Value = Request.QueryString("soid")
        e.Command.Parameters("@CustomerCompanyID").Value = Me.CustomerDropDownList.SelectedValue 'Me.CustomerIDHiddenField.Value
        If Me.CarrierIDHiddenField.Value <> "" Then
            e.Command.Parameters("@CarrierCompanyID").Value = Me.CarrierIDHiddenField.Value
            e.Command.Parameters("@StatusType").Value = "Assigned"
        Else
            e.Command.Parameters("@StatusType").Value = "Pending"
        End If
        e.Command.Parameters("@CarrierContact").Value = Me.CarrierContactTextBox.Text
        e.Command.Parameters("@CarrierPhone").Value = Me.CarrierPhoneTextBox.Text
        e.Command.Parameters("@CarrierFax").Value = Me.CarrierFaxTextBox.Text
        e.Command.Parameters("@CarrierEmail").Value = Me.EmailTextBox.Text
        e.Command.Parameters("@Notes").Value = sb.ToString 'Me.NotesTextBox.Text
        'e.Command.Parameters("@CustomerPONumber").Value = Me.CustomerPONumberTextBox.Text
        e.Command.Parameters("@CustomerBillAmount").Value = Me.CustomerBillAmount.Text
        e.Command.Parameters("@CarrierPayAmount").Value = Me.CarrierPayAmountTextBox.Text
        'e.Command.Parameters("@CarrierDriverName").Value = Me.DriverNameTextBox.Text
        'e.Command.Parameters("@CarrierDriverCell").Value = Me.CellPhoneTextBox.Text
        e.Command.Parameters("@CommodityType").Value = Nothing
        If Me.LoadTypeDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@LoadType").Value = Me.LoadTypeDropDownList.SelectedValue
        If Me.TarpDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@Tarp").Value = Me.TarpDropDownList.SelectedValue
        e.Command.Parameters("@Weight").Value = Me.WeightTextBox.Text
        'If Me.OrderStatusDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@StatusType").Value = Me.OrderStatusDropDownList.SelectedValue



        e.Command.Parameters("@CitationContact").Value = Me.CitationContactTextBox.Text
        'If Me.ShippingOrderNumberTextBox.Text <> "[Auto]" Then e.Command.Parameters("@OrderNumber").Value = Me.ShippingOrderNumberTextBox.Text
        'If Me.ShippingOrderNumberTextBox.Text = "[Auto]" AndAlso Val(Me.CarrierIDHiddenField.Value) > 0 AndAlso Me.OrderStatusDropDownList.SelectedValue = "Assigned" Then
        'e.Command.Parameters("@OrderNumber").Value = Nothing 'GetNextOrderNumber()
        'Else
        'If Me.ShippingOrderNumberTextBox.Text <> "[Auto]" Then
        '    Dim i As Integer = GetNextOrderNumber()
        '    e.Command.Parameters("@OrderNumber").Value = Me.ShippingOrderNumberTextBox.Text
        'End If
        'if we have a date, get the order number
        'If IsDate(Me.OrderDateTextBox.Text) Then

        'End If
        'End If


        'If Me.OrderDateTextBox.Text = "[Auto]" AndAlso Val(Me.CarrierIDHiddenField.Value) > 0 AndAlso Me.OrderStatusDropDownList.SelectedValue = "Assigned" Then
        '    e.Command.Parameters("@OrderDate").Value = Now.ToShortDateString
        'ElseIf IsDate(Me.OrderDateTextBox.Text) Then
        '    e.Command.Parameters("@OrderDate").Value = Me.OrderDateTextBox.Text
        'End If

        'If IsDate(Me.OrderDateTextBox.Text) AndAlso Me.OrderStatusDropDownList.SelectedValue = "Assigned" Then 'Val(Me.CarrierIDHiddenField.Value) > 0 AndAlso
        '    If Not IsNumeric(Me.ShippingOrderNumberTextBox.Text) Then
        '        e.Command.Parameters("@OrderNumber").Value = Me.GetNextOrderNumber
        '    Else
        '        e.Command.Parameters("@OrderNumber").Value = Me.ShippingOrderNumberTextBox.Text
        '    End If
        '    e.Command.Parameters("@OrderDate").Value = Me.OrderDateTextBox.Text
        'End If

        'if we have a date and no order number and we're not cancelled or pending
        'else we have a date and an order number use the on-screen vals
        'If IsDate(Me.OrderDateTextBox.Text) AndAlso Not IsNumeric(Me.ShippingOrderNumberTextBox.Text) AndAlso Me.OrderStatusDropDownList.SelectedValue <> "Pending" AndAlso Me.OrderStatusDropDownList.SelectedValue <> "Cancelled" Then
        '    e.Command.Parameters("@OrderNumber").Value = Me.GetNextOrderNumber
        '    e.Command.Parameters("@OrderDate").Value = Me.OrderDateTextBox.Text
        'ElseIf IsDate(Me.OrderDateTextBox.Text) AndAlso IsNumeric(Me.ShippingOrderNumberTextBox.Text) Then
        '    e.Command.Parameters("@OrderNumber").Value = Me.ShippingOrderNumberTextBox.Text
        '    e.Command.Parameters("@OrderDate").Value = Me.OrderDateTextBox.Text
        'End If

        e.Command.Parameters("@OrderNumber").Value = Me.GetNextOrderNumber
        e.Command.Parameters("@OrderDate").Value = Now.ToShortDateString




        'a1
        If Me.AddActivityWebUserControl1.aActivityTypeDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@a1ActivityType").Value = Me.AddActivityWebUserControl1.aActivityTypeDropDownList.SelectedValue
        If Me.AddActivityWebUserControl1.aLocationIDTextBox.Text <> "" Then e.Command.Parameters("@a1LocationCompanyID").Value = Me.AddActivityWebUserControl1.aLocationIDTextBox.Text
        e.Command.Parameters("@a1Address1").Value = Me.AddActivityWebUserControl1.aActivityAddress1TextBox.Text
        e.Command.Parameters("@a1Address2").Value = Me.AddActivityWebUserControl1.aActivityAddress2TextBox.Text
        e.Command.Parameters("@a1City").Value = Me.AddActivityWebUserControl1.aActivityCityTextBox.Text
        If Me.AddActivityWebUserControl1.aActivityStateDropdownList.SelectedIndex > -1 Then e.Command.Parameters("@a1State").Value = Me.AddActivityWebUserControl1.aActivityStateDropdownList.SelectedValue
        e.Command.Parameters("@a1PostalCode").Value = Me.AddActivityWebUserControl1.aActivityPostalCodeTextBox.Text
        e.Command.Parameters("@a1Notes").Value = Me.AddActivityWebUserControl1.aActivityNotesTextBox.Text
        If IsDate(Me.AddActivityWebUserControl1.aCompletionDateTextBox.Text) Then e.Command.Parameters("@a1CompletionDate").Value = Me.AddActivityWebUserControl1.aCompletionDateTextBox.Text
        'e.command.parameters("@a1Status").value = xxxxxxxxxxxxx
        e.Command.Parameters("@a1ActivityDate").Value = Me.AddActivityWebUserControl1.aActivityDateTextBox.Text
        'If Me.AddActivityWebUserControl1.aCommodityTypeDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@a1CommodityType").Value = Me.AddActivityWebUserControl1.aCommodityTypeDropDownList.SelectedValue
        e.Command.Parameters("@a1CommodityType").Value = Me.AddActivityWebUserControl1.aCommodityTypeTextBox.Text
        e.Command.Parameters("@a1Phone").Value = Me.AddActivityWebUserControl1.aActivityPhoneTextBox.Text
        e.Command.Parameters("@a1Contact").Value = Me.AddActivityWebUserControl1.aContactTextBox.Text
        e.Command.Parameters("@a1ActivityTime").Value = Me.AddActivityWebUserControl1.aActivityTimeTextBox.Text

        'a2
        If Me.AddActivityWebUserControl2.aActivityTypeDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@a2ActivityType").Value = Me.AddActivityWebUserControl2.aActivityTypeDropDownList.SelectedValue
        If Me.AddActivityWebUserControl2.aLocationIDTextBox.Text <> "" Then e.Command.Parameters("@a2LocationCompanyID").Value = Me.AddActivityWebUserControl2.aLocationIDTextBox.Text
        e.Command.Parameters("@a2Address1").Value = Me.AddActivityWebUserControl2.aActivityAddress1TextBox.Text
        e.Command.Parameters("@a2Address2").Value = Me.AddActivityWebUserControl2.aActivityAddress2TextBox.Text
        e.Command.Parameters("@a2City").Value = Me.AddActivityWebUserControl2.aActivityCityTextBox.Text
        If Me.AddActivityWebUserControl2.aActivityStateDropdownList.SelectedIndex > -1 Then e.Command.Parameters("@a2State").Value = Me.AddActivityWebUserControl2.aActivityStateDropdownList.SelectedValue
        e.Command.Parameters("@a2PostalCode").Value = Me.AddActivityWebUserControl2.aActivityPostalCodeTextBox.Text
        e.Command.Parameters("@a2Notes").Value = Me.AddActivityWebUserControl2.aActivityNotesTextBox.Text
        If IsDate(Me.AddActivityWebUserControl2.aCompletionDateTextBox.Text) Then e.Command.Parameters("@a2CompletionDate").Value = Me.AddActivityWebUserControl2.aCompletionDateTextBox.Text
        'e.command.parameters("@a2Status").value = xxxxxxxxxxxxx
        e.Command.Parameters("@a2ActivityDate").Value = Me.AddActivityWebUserControl2.aActivityDateTextBox.Text
        'If Me.AddActivityWebUserControl2.aCommodityTypeDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@a2CommodityType").Value = Me.AddActivityWebUserControl2.aCommodityTypeDropDownList.SelectedValue
        e.Command.Parameters("@a2CommodityType").Value = Me.AddActivityWebUserControl2.aCommodityTypeTextBox.Text
        e.Command.Parameters("@a2Phone").Value = Me.AddActivityWebUserControl2.aActivityPhoneTextBox.Text
        e.Command.Parameters("@a2Contact").Value = Me.AddActivityWebUserControl2.aContactTextBox.Text
        e.Command.Parameters("@a2ActivityTime").Value = Me.AddActivityWebUserControl2.aActivityTimeTextBox.Text

        'a3
        If Me.AddActivityWebUserControl3.aActivityTypeDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@a3ActivityType").Value = Me.AddActivityWebUserControl3.aActivityTypeDropDownList.SelectedValue
        If Me.AddActivityWebUserControl3.aLocationIDTextBox.Text <> "" Then e.Command.Parameters("@a3LocationCompanyID").Value = Me.AddActivityWebUserControl3.aLocationIDTextBox.Text
        e.Command.Parameters("@a3Address1").Value = Me.AddActivityWebUserControl3.aActivityAddress1TextBox.Text
        e.Command.Parameters("@a3Address2").Value = Me.AddActivityWebUserControl3.aActivityAddress2TextBox.Text
        e.Command.Parameters("@a3City").Value = Me.AddActivityWebUserControl3.aActivityCityTextBox.Text
        If Me.AddActivityWebUserControl3.aActivityStateDropdownList.SelectedIndex > -1 Then e.Command.Parameters("@a3State").Value = Me.AddActivityWebUserControl3.aActivityStateDropdownList.SelectedValue
        e.Command.Parameters("@a3PostalCode").Value = Me.AddActivityWebUserControl3.aActivityPostalCodeTextBox.Text
        e.Command.Parameters("@a3Notes").Value = Me.AddActivityWebUserControl3.aActivityNotesTextBox.Text
        If IsDate(Me.AddActivityWebUserControl3.aCompletionDateTextBox.Text) Then e.Command.Parameters("@a3CompletionDate").Value = Me.AddActivityWebUserControl3.aCompletionDateTextBox.Text
        'e.command.parameters("@a3Status").value = xxxxxxxxxxxxx
        e.Command.Parameters("@a3ActivityDate").Value = Me.AddActivityWebUserControl3.aActivityDateTextBox.Text
        'If Me.AddActivityWebUserControl3.aCommodityTypeDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@a3CommodityType").Value = Me.AddActivityWebUserControl3.aCommodityTypeDropDownList.SelectedValue
        e.Command.Parameters("@a3CommodityType").Value = Me.AddActivityWebUserControl3.aCommodityTypeTextBox.Text
        e.Command.Parameters("@a3Phone").Value = Me.AddActivityWebUserControl3.aActivityPhoneTextBox.Text
        e.Command.Parameters("@a3Contact").Value = Me.AddActivityWebUserControl3.aContactTextBox.Text
        e.Command.Parameters("@a3ActivityTime").Value = Me.AddActivityWebUserControl3.aActivityTimeTextBox.Text

        'a4
        If Me.AddActivityWebUserControl4.aActivityTypeDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@a4ActivityType").Value = Me.AddActivityWebUserControl4.aActivityTypeDropDownList.SelectedValue
        If Me.AddActivityWebUserControl4.aLocationIDTextBox.Text <> "" Then e.Command.Parameters("@a4LocationCompanyID").Value = Me.AddActivityWebUserControl4.aLocationIDTextBox.Text
        e.Command.Parameters("@a4Address1").Value = Me.AddActivityWebUserControl4.aActivityAddress1TextBox.Text
        e.Command.Parameters("@a4Address2").Value = Me.AddActivityWebUserControl4.aActivityAddress2TextBox.Text
        e.Command.Parameters("@a4City").Value = Me.AddActivityWebUserControl4.aActivityCityTextBox.Text
        If Me.AddActivityWebUserControl4.aActivityStateDropdownList.SelectedIndex > -1 Then e.Command.Parameters("@a4State").Value = Me.AddActivityWebUserControl4.aActivityStateDropdownList.SelectedValue
        e.Command.Parameters("@a4PostalCode").Value = Me.AddActivityWebUserControl4.aActivityPostalCodeTextBox.Text
        e.Command.Parameters("@a4Notes").Value = Me.AddActivityWebUserControl4.aActivityNotesTextBox.Text
        If IsDate(Me.AddActivityWebUserControl4.aCompletionDateTextBox.Text) Then e.Command.Parameters("@a4CompletionDate").Value = Me.AddActivityWebUserControl4.aCompletionDateTextBox.Text
        'e.command.parameters("@a4Status").value = xxxxxxxxxxxxx
        e.Command.Parameters("@a4ActivityDate").Value = Me.AddActivityWebUserControl4.aActivityDateTextBox.Text
        'If Me.AddActivityWebUserControl4.aCommodityTypeDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@a4CommodityType").Value = Me.AddActivityWebUserControl4.aCommodityTypeDropDownList.SelectedValue
        e.Command.Parameters("@a4CommodityType").Value = Me.AddActivityWebUserControl4.aCommodityTypeTextBox.Text
        e.Command.Parameters("@a4Phone").Value = Me.AddActivityWebUserControl4.aActivityPhoneTextBox.Text
        e.Command.Parameters("@a4Contact").Value = Me.AddActivityWebUserControl4.aContactTextBox.Text
        e.Command.Parameters("@a4ActivityTime").Value = Me.AddActivityWebUserControl4.aActivityTimeTextBox.Text

        e.Command.Parameters("@ExtraCharge1Amount").Value = Me.ExtraCharge1AmountTextBox.Text
        e.Command.Parameters("@ExtraCharge1Description").Value = Me.ExtraCharge1DescriptionTextBox.Text
        e.Command.Parameters("@ExtraPay1Amount").Value = Me.ExtraPay1AmountTextBox.Text
        ' e.Command.Parameters("@ExtraPay1Description").Value = Me.ExtraPay1DescriptionTextBox.Text

        e.Command.Parameters("@CustomerContact").Value = Me.CustomerContactTextBox.Text


        e.Command.Parameters("@a1ActivityTimeEnd").Value = Me.AddActivityWebUserControl1.aActivityTimeEndTextBox.Text
        e.Command.Parameters("@a2ActivityTimeEnd").Value = Me.AddActivityWebUserControl2.aActivityTimeEndTextBox.Text
        e.Command.Parameters("@a3ActivityTimeEnd").Value = Me.AddActivityWebUserControl3.aActivityTimeEndTextBox.Text
        e.Command.Parameters("@a4ActivityTimeEnd").Value = Me.AddActivityWebUserControl4.aActivityTimeEndTextBox.Text

        e.Command.Parameters("@PO").Value = Me.POTextBox.Text
        e.Command.Parameters("@Priority").Value = Me.PriorityDropDownList.SelectedValue


    End Sub



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then




            Me.AddActivityWebUserControl1.SetTabIndex(100)
            Me.AddActivityWebUserControl2.SetTabIndex(200)
            Me.AddActivityWebUserControl3.SetTabIndex(300)
            Me.AddActivityWebUserControl4.SetTabIndex(400)




            If Not Me.Session("Orders.StartDate") Is Nothing Then
                Me.StartDateTextBox.Text = Me.Session("Orders.StartDate")
            Else
                Me.StartDateTextBox.Text = Now.ToShortDateString
            End If
            If Not Me.Session("Orders.EndDate") Is Nothing Then
                Me.EndDateTextBox.Text = Me.Session("Orders.EndDate")
            Else
                Me.EndDateTextBox.Text = Now.ToShortDateString
            End If
            If Not Me.Session("Orders.OrderStatus.SelectedIndex") Is Nothing Then
                Me.OrderStatusDropDownList.SelectedIndex = Me.Session("Orders.OrderStatus.SelectedIndex")
            End If
            If Not Me.Session("Orders.OrderNumber") Is Nothing Then
                Me.OrderNumberTextBox.Text = Me.Session("Orders.OrderNumber")
            End If


        End If
    End Sub






    Protected Sub OrderStatusDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles OrderStatusDropDownList.SelectedIndexChanged
        Me.OrdersGridView.DataBind()
    End Sub

    'Protected Sub NewOrderButton_Click(sender As Object, e As EventArgs) Handles NewOrderButton.Click, NewOrderButton1.Click
    '    Response.Redirect("~/NewOrder.aspx")
    'End Sub


    Protected Sub EditButton_Click(sender As Object, e As EventArgs)
        Dim i As Integer = CType(sender, LinkButton).CommandArgument
        Response.Redirect("~/NewOrder.aspx?soid=" & i.ToString)
    End Sub

    'Protected Sub PrintButton_Click(sender As Object, e As EventArgs)

    '    Dim i As Integer = CType(sender, LinkButton).CommandArgument

    '    Dim dt As New ShippingOrderDataSet.LoadConfirmationSheetDataTable
    '    Using ta As New ShippingOrderDataSetTableAdapters.LoadConfirmationSheetTableAdapter
    '        ta.Fill(dt, i)
    '    End Using
    '    If dt.Rows.Count = 1 Then
    '        Dim viewer As New Microsoft.Reporting.WebForms.ReportViewer()

    '        'Create Report Data Source
    '        Dim rptDataSource As New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt.DefaultView)

    '        viewer.LocalReport.DataSources.Add(rptDataSource)
    '        viewer.LocalReport.ReportPath = Server.MapPath("~/LoadConfirmationSheetReport.rdlc")

    '        Dim fn As String = ""
    '        If CType(sender, LinkButton).ID = "PrintBOLButton" Then
    '            viewer.LocalReport.ReportPath = Server.MapPath("~/BillOfLadingReport.rdlc")
    '            fn = "BillOfLading"
    '        Else
    '            fn = "LoadConfirmationSheet"
    '            viewer.LocalReport.ReportPath = Server.MapPath("~/LoadConfirmationSheetReport.rdlc")
    '        End If

    '        'Export to PDF
    '        Dim pdfContent As Byte() = viewer.LocalReport.Render("PDF", Nothing, Nothing, Nothing, Nothing, Nothing, Nothing)


    '        'Return PDF
    '        Me.Response.Clear()
    '        Me.Response.ContentType = "application/pdf"
    '        Me.Response.AddHeader("Content-disposition", "attachment; filename=" + fn + ".pdf")
    '        Me.Response.BinaryWrite(pdfContent)
    '        Me.Response.End()

    '    End If
    'End Sub




    Protected Sub DuplicateButton_Click(sender As Object, e As EventArgs)
        Dim i As Integer = CType(sender, LinkButton).CommandArgument


        Dim con As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Try
            Dim cmd As New SqlClient.SqlCommand
            With cmd
                .Connection = con
                .CommandText = "[CopyShippingOrder]"
                .CommandType = CommandType.StoredProcedure
                .Connection.Open()
                .Parameters.AddWithValue("@ShippingOrderID", i)
                .Parameters.AddWithValue("@Copies", 1)
                .ExecuteNonQuery()
            End With
        Catch ex As Exception
            '            Me.CopyMessageLabel.text = ex.ToString
        Finally
            con.Close()
        End Try

        Me.OrdersGridView.DataBind()


        '      Response.Redirect("~/NewOrder.aspx?soid=" & i.ToString)
    End Sub

    Protected Sub SearchButton_Click(sender As Object, e As EventArgs) Handles SearchButton.Click
        Me.OrdersGridView.DataBind()
    End Sub

    'Private Sub OrderStatusSqlDataSource_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles OrderStatusSqlDataSource.Selecting
    '    Me.Session("Orders.StartDate") = Me.StartDateTextBox.Text
    '    Me.Session("Orders.EndDate") = Me.EndDateTextBox.Text
    '    Me.Session("Orders.OrderStatus.SelectedIndex") = Me.OrderStatusDropDownList.SelectedIndex
    '    Me.Session("Orders.OrderNumber") = Me.OrderNumberTextBox.Text
    'End Sub

    Private Sub OrderStatusDropDownList_DataBound(sender As Object, e As EventArgs) Handles OrderStatusDropDownList.DataBound
        Try
            OrderStatusDropDownList.ClearSelection()
            OrderStatusDropDownList.Items.FindByValue("Assigned").Selected = True
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub OrdersGridView_Init(sender As Object, e As EventArgs)

    End Sub


    Protected Sub SaveButton_Click(sender As Object, e As EventArgs) Handles SaveButton.Click

        Dim soid As Integer = 0
        'If Request.QueryString("soid") = "" Then
        Me.OrdersSqlDataSource.Insert()
            Dim con As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
            Try
            Using cmd As New SqlCommand("Select top 1 shippingorderid from shippingorder where customercompanyid = " & Me.CustomerDropDownList.SelectedValue & " order by shippingorderid desc", con)
                With cmd
                    .Connection.Open()
                    .CommandType = CommandType.Text
                    soid = .ExecuteScalar()
                End With
            End Using

            Me.OrdersGridView.DataBind()
        Catch ex As Exception
            Throw ex

        Finally
                con.Close()
            End Try

        'End If
        'UpdateCarrierInfo()
        'Response.Redirect("Dashboard.aspx?soid=" & soid.ToString)
    End Sub
    Dim OrderCount As Integer = 0
    Private Sub OrdersGridView_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles OrdersGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            OrderCount += 1


            If CType(e.Row.FindControl("CarrierNameHiddenField"), HiddenField).Value <> "" Then




                Dim CarrierInfoMessage As StringBuilder = New StringBuilder
                Dim CarrierErrorCount As Int16 = 0
                Dim CargoD As String = CType(e.Row.FindControl("CargoInsuranceExpirationDateHiddenField"), HiddenField).Value

                If String.IsNullOrEmpty(CargoD) Then
                    'CType(e.Row.FindControl("CargoInsuranceBadge"), HtmlGenericControl).Attributes.Add("class", "badge badge-pill badge-danger")
                    'CType(e.Row.FindControl("CargoInsuranceBadgeLabel"), Label).Text = "Missing"
                    CarrierInfoMessage.AppendLine("Missing Cargo Insurance")
                    CarrierErrorCount += 1
                ElseIf IsDate(cargod) AndAlso Date.Parse(cargod) < Now() Then
                    'CType(e.Row.FindControl("CargoInsuranceBadge"), HtmlGenericControl).Attributes.Add("class", "badge badge-pill badge-danger")
                    'CType(e.Row.FindControl("CargoInsuranceBadgeLabel"), Label).Text = "Expired".
                    CarrierInfoMessage.AppendLine("Cargo Insurance is Expired")
                    CarrierErrorCount += 1
                ElseIf IsDate(CargoD) AndAlso Date.Parse(CargoD) > Now() Then
                    'CType(e.Row.FindControl("CargoInsuranceBadge"), HtmlGenericControl).Attributes.Add("class", "badge badge-pill badge-success")
                    'CType(e.Row.FindControl("CargoInsuranceBadgeLabel"), Label).Text = CargoD
                    CarrierInfoMessage.AppendLine("Cargo Insurance expires on " + Date.Parse(CargoD).ToShortDateString)

                End If




                Dim LiabilityD As String = CType(e.Row.FindControl("LiabilityInsuranceExpirationDateHiddenField"), HiddenField).Value

                If String.IsNullOrEmpty(LiabilityD) Then
                    'CType(e.Row.FindControl("LiabilityInsuranceBadge"), HtmlGenericControl).Attributes.Add("class", "badge badge-pill badge-danger")
                    'CType(e.Row.FindControl("LiabilityInsuranceBadgeLabel"), Label).Text = "Missing"
                    CarrierInfoMessage.AppendLine("Missing Liability Insurance")
                    CarrierErrorCount += 1
                ElseIf IsDate(LiabilityD) AndAlso Date.Parse(LiabilityD) < Now() Then
                    'CType(e.Row.FindControl("LiabilityInsuranceBadge"), HtmlGenericControl).Attributes.Add("class", "badge badge-pill badge-danger")
                    'CType(e.Row.FindControl("LiabilityInsuranceBadgeLabel"), Label).Text = "Expired"
                    CarrierInfoMessage.AppendLine("Liability Insurance is Expired")
                    CarrierErrorCount += 1
                ElseIf IsDate(LiabilityD) AndAlso Date.Parse(LiabilityD) > Now() Then
                    'CType(e.Row.FindControl("LiabilityInsuranceBadge"), HtmlGenericControl).Attributes.Add("class", "badge badge-pill badge-success")
                    'CType(e.Row.FindControl("LiabilityInsuranceBadgeLabel"), Label).Text = LiabilityD
                    CarrierInfoMessage.AppendLine("Liability Insurance expires on " + Date.Parse(LiabilityD).ToShortDateString)
                End If


                Dim mcNumber As String = CType(e.Row.FindControl("MCnumberHiddenField"), HiddenField).Value

                If String.IsNullOrEmpty(mcNumber) Then
                    'CType(e.Row.FindControl("MCNumberBadge"), HtmlGenericControl).Attributes.Add("class", "badge badge-pill badge-danger")
                    'CType(e.Row.FindControl("MCNumberBadgeLabel"), Label).Text = "Missing"
                    CarrierInfoMessage.AppendLine("MC Number is missing")
                    CarrierErrorCount += 1

                Else
                    'CType(e.Row.FindControl("MCNumberBadge"), HtmlGenericControl).Attributes.Add("class", "badge badge-pill badge-success")
                    'CType(e.Row.FindControl("MCNumberBadgeLabel"), Label).Text = mcNumber
                    CarrierInfoMessage.AppendLine("MC Number is " + mcNumber)
                End If

                If CarrierErrorCount > 0 Then
                    CType(e.Row.FindControl("CarrierInfoMessage"), Label).Text = String.Format("{0} Errors", CarrierErrorCount)
                    CType(e.Row.FindControl("CarrierInfoBadge"), HtmlGenericControl).Attributes.Add("class", "badge badge-danger")
                Else
                    CType(e.Row.FindControl("CarrierInfoMessage"), Label).Text = "Okay"

                    CType(e.Row.FindControl("CarrierInfoBadge"), HtmlGenericControl).Attributes.Add("class", "badge badge-success")
                End If
                CType(e.Row.FindControl("CarrierInfoMessage"), Label).ToolTip = CarrierInfoMessage.ToString

            End If

            Try
                Select Case CType(e.Row.FindControl("PriorityHiddenField"), HiddenField).Value
                    Case "1"
                        e.Row.CssClass += "table-warning"
                    Case "2"
                        e.Row.CssClass += "table-default"

                    Case Else
                        e.Row.CssClass += "table-secondary"

                End Select


            Catch ex As Exception

            End Try
        End If

        'Dim lihf As HiddenField = e.Row.FindControl("LiabilityInsuranceExpirationDateHiddenField")
        'Dim mchf As HiddenField = e.Row.FindControl("MCNumberHiddenField")
    End Sub

    Private Sub OrdersGridView_DataBound(sender As Object, e As EventArgs) Handles OrdersGridView.DataBound
        Me.CountLabel.Text = OrderCount
    End Sub

    Protected Sub CarrierTextBox_TextChanged(sender As Object, e As EventArgs) Handles CarrierTextBox.TextChanged

        If Me.CarrierIDHiddenField.Value = Nothing Then

            'get the text
            Dim s As String = Me.CarrierTextBox.Text

            'clear the box
            Me.CarrierTextBox.Text = ""

            'popup the editor
            Me.NewCarrierPopUpControl.CompanyName = s
            Me.NewCarrierPopUpControl.isVendor = True
            Me.NewCarrierPopUpControl.isCustomer = False
            Me.NewCarrierPopUpControl.ShowPopup()

        Else
            Me.LoadCarrierInfo(Integer.Parse(Me.CarrierIDHiddenField.Value))
            Me.CarrierContactTextBox.Focus()
        End If
    End Sub

    Private Sub NewCarrierPopUpControl_Company_Updated(CompanyID As Integer) Handles NewCarrierPopUpControl.Company_Updated
        Me.CarrierIDHiddenField.Value = CompanyID
        Me.CarrierTextBox.Text = NewCarrierPopUpControl.GetCompanyNameFromSQL(CompanyID)
        LoadCarrierInfo(CompanyID)
        Me.CarrierSelectorUpdatePanel.Update()
    End Sub

    Private Sub LoadCarrierInfo(id As Integer)
        Try
            Dim GetDefaults As Boolean = False


            Dim t As New ShippingOrderDataSet.CarrierInfoFromLastOrderDataTable
            Using ta As New ShippingOrderDataSetTableAdapters.CarrierInfoFromLastOrderTableAdapter

                ta.Fill(t, id)
            End Using
            If t.Rows.Count > 0 Then
                Dim r As ShippingOrderDataSet.CarrierInfoFromLastOrderRow = t.Rows(0)


                If Not r.IsCarrierContactNull Then Me.CarrierContactTextBox.Text = r.CarrierContact
                If Not r.IsCarrierPhoneNull Then Me.CarrierPhoneTextBox.Text = r.CarrierPhone
                If Not r.IsCarrierFaxNull Then Me.CarrierFaxTextBox.Text = r.CarrierFax
                If Not r.IsCarrierEmailNull Then Me.EmailTextBox.Text = r.CarrierEmail
                If Not r.IsCarrierDriverNameNull Then Me.DriverNameTextBox.Text = r.CarrierDriverName
                If Not r.IsCarrierDriverCellNull Then Me.CellPhoneTextBox.Text = r.CarrierDriverCell


            Else
                GetDefaults = True
            End If

            If GetDefaults Then
                Dim t1 As New ShippingOrderDataSet.CompanySelectDataTable
                Using ta1 As New ShippingOrderDataSetTableAdapters.CompanySelectTableAdapter

                    ta1.Fill(t1, id)
                End Using
                If t1.Rows.Count > 0 Then
                    Dim r As ShippingOrderDataSet.CompanySelectRow = t1.Rows(0)

                    If Not r.IsContactNull Then Me.CarrierContactTextBox.Text = r.Contact
                    If Not r.IsemailNull Then Me.EmailTextBox.Text = r.email
                    If Not r.IsFaxNull Then Me.CarrierFaxTextBox.Text = r.Fax
                    If Not r.IsPhoneNull Then Me.CarrierPhoneTextBox.Text = r.Phone

                End If
            End If


        Catch ex As Exception

        End Try

        'Me.ActivityUpdatePanel.update()
    End Sub



    <System.Web.Script.Services.ScriptMethod(),
System.Web.Services.WebMethod()>
    Public Shared Function SearchCarriers(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
        Dim conn As SqlConnection = New SqlConnection
        conn.ConnectionString = ConfigurationManager _
             .ConnectionStrings("DefaultConnection").ConnectionString
        Dim cmd As SqlCommand = New SqlCommand
        cmd.CommandText = "select id, companyname + ' (' + isnull(bCity,'Unknown City') + ', ' + isnull(bState,'Unknown State') + ')' + isnull(' MC# ' + MCNumber,'') as CompanyName from company where isnull(disabled,0) = 0 and isnull(vendor,0) = 1 and companyname + '/' + isnull(' MC# ' + MCNumber,'') like '%' + @SearchText + '%' order by companyName"
        cmd.Parameters.AddWithValue("@SearchText", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim c As List(Of String) = New List(Of String)
        Dim sdr As SqlDataReader = cmd.ExecuteReader
        While sdr.Read
            Dim item As String = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("CompanyName").ToString, sdr("id").ToString)
            c.Add(item)
            'c.Add(sdr("CompanyName").ToString)
        End While
        conn.Close()
        Return c
    End Function


End Class