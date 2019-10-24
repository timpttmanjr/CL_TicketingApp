Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.Services
Imports System.Data
Imports System.Data.SqlClient
Public Class NewOrder
    Inherits System.Web.UI.Page

   
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Request.QueryString("soid") <> "" Then
                LoadOrder()
            Else
                Dim sb As New StringBuilder
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
                sb.AppendLine("*ALL SHIPMENTS ARE TIME CRITICAL.  FAILURE TO MEET DELIVERY TIME LISTED ON RATE CONFIRMATION WILL RESULT IN A RATE DEDUCTION!!  WE MUST BE NOTIFIED IMMEDIATELY IF ANY ISSUES OCCUR TO DELAY ON TIME PICK UP OR DELIVERY.  WE ARE AVAILABLE 24/7 AT (985)-641-8233*")
                sb.AppendLine()
                sb.AppendLine("*ALL SHIPMENTS ARE CONSIDERED DEDICATED UNLESS NOTED OTHERWISE ON RATE CONFIRMATION.")
                Me.NotesTextBox.Text = sb.ToString
            End If
            Me.AddActivityWebUserControl1.SetTabIndex(100)
            Me.AddActivityWebUserControl2.SetTabIndex(200)
            Me.AddActivityWebUserControl3.SetTabIndex(300)
            Me.AddActivityWebUserControl4.SetTabIndex(400)
        End If
    End Sub




    '<System.Web.Script.Services.ScriptMethod(), _
    'System.Web.Services.WebMethod()> _
    'Public Shared Function SearchCustomers(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
    '    Dim conn As SqlConnection = New SqlConnection
    '    conn.ConnectionString = ConfigurationManager _
    '         .ConnectionStrings("DefaultConnection").ConnectionString
    '    Dim cmd As SqlCommand = New SqlCommand
    '    cmd.CommandText = "select id, companyname + ' (' + isnull(bCity,'Unknown City') + ', ' + isnull(bState,'Unknown State') + ')' as CompanyName from company where Customer = 1 and companyname + '/' + isnull(bCity,'Unknown City') + '/' + isnull(bState,'Unknown State') like '%' + @SearchText + '%'"
    '    cmd.Parameters.AddWithValue("@SearchText", prefixText)
    '    cmd.Connection = conn
    '    conn.Open()
    '    Dim c As List(Of String) = New List(Of String)
    '    Dim sdr As SqlDataReader = cmd.ExecuteReader
    '    While sdr.Read
    '        Dim item As String = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("CompanyName").ToString, sdr("id").ToString)
    '        c.Add(item)
    '        'c.Add(sdr("CompanyName").ToString)
    '    End While
    '    conn.Close()
    '    Return c
    'End Function

    'Protected Sub CustomerTextBox_TextChanged(sender As Object, e As EventArgs) Handles CustomerTextBox.TextChanged
    '    If Me.CustomerIDHiddenField.Value = Nothing Then
    '        Me.CustomerTextBox.Text = ""
    '    Else
    '        Me.LoadCustomerInfo(Integer.Parse(Me.CustomerIDHiddenField.Value))
    '        'Me.CustomerPONumberTextBox.Focus()
    '    End If
    'End Sub

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



    <System.Web.Script.Services.ScriptMethod(), _
System.Web.Services.WebMethod()> _
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

    <System.Web.Script.Services.ScriptMethod(), _
System.Web.Services.WebMethod()> _
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

    Protected Sub OrderStatusDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles OrderStatusDropDownList.SelectedIndexChanged
        If Me.OrderStatusDropDownList.SelectedValue = "Assigned" AndAlso Me.ShippingOrderNumberTextBox.Text = "[Auto]" AndAlso Me.OrderDateTextBox.Text = "[Auto]" Then
            'Me.ShippingOrderNumberTextBox.Text = GetNextOrderNumber()
            Me.OrderDateTextBox.Text = Now.ToShortDateString
        End If
    End Sub

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

    'Protected Sub NewCustomerImageButton_Click(sender As Object, e As ImageClickEventArgs) Handles NewCustomerImageButton.Click
    '    Dim x As String = Me.CustomerIDHiddenField.Value
    'End Sub

    Private Sub OrdersSqlDataSource_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles OrdersSqlDataSource.Inserting
        'e.command.parameters("@ShippingOrderID").value = xxxxxxxxxxxxx
        e.Command.Parameters("@CustomerCompanyID").Value = Me.CustomerDropDownList.SelectedValue 'Me.CustomerIDHiddenField.Value
        If Me.CarrierIDHiddenField.Value <> "" Then e.Command.Parameters("@CarrierCompanyID").Value = Me.CarrierIDHiddenField.Value
        e.Command.Parameters("@CarrierContact").Value = Me.CarrierContactTextBox.Text
        e.Command.Parameters("@CarrierPhone").Value = Me.CarrierPhoneTextBox.Text
        e.Command.Parameters("@CarrierFax").Value = Me.CarrierFaxTextBox.Text
        e.Command.Parameters("@CarrierEmail").Value = Me.EmailTextBox.Text
        e.Command.Parameters("@Notes").Value = Me.NotesTextBox.Text
        'e.Command.Parameters("@CustomerPONumber").Value = Me.CustomerPONumberTextBox.Text
        e.Command.Parameters("@CustomerBillAmount").Value = Me.CustomerBillAmount.Text
        e.Command.Parameters("@CarrierPayAmount").Value = Me.CarrierPayAmountTextBox.Text
        e.Command.Parameters("@CarrierDriverName").Value = Me.DriverNameTextBox.Text
        e.Command.Parameters("@CarrierDriverCell").Value = Me.CellPhoneTextBox.Text
        e.Command.Parameters("@CommodityType").Value = Nothing
        If Me.LoadTypeDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@LoadType").Value = Me.LoadTypeDropDownList.SelectedValue
        If Me.TarpDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@Tarp").Value = Me.TarpDropDownList.SelectedValue
        e.Command.Parameters("@Weight").Value = Me.WeightTextBox.Text
        If Me.OrderStatusDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@StatusType").Value = Me.OrderStatusDropDownList.SelectedValue
        e.Command.Parameters("@CitationContact").Value = Me.CitationContactTextBox.Text



        If IsDate(Me.OrderDateTextBox.Text) AndAlso Me.OrderStatusDropDownList.SelectedValue = "Assigned" Then 'AndAlso Val(Me.CarrierIDHiddenField.Value) > 0
            If Not IsNumeric(Me.ShippingOrderNumberTextBox.Text) Then
                e.Command.Parameters("@OrderNumber").Value = Me.GetNextOrderNumber
            Else
                e.Command.Parameters("@OrderNumber").Value = Me.ShippingOrderNumberTextBox.Text
            End If
            e.Command.Parameters("@OrderDate").Value = Me.OrderDateTextBox.Text
        End If



        'If Not Me.ShippingOrderNumberTextBox.Text.Contains("Auto") Then e.Command.Parameters("@OrderNumber").Value = Me.ShippingOrderNumberTextBox.Text
        ''e.Command.Parameters("@OrderNumber").Value = GetNextOrderNumber()
        'If IsDate(Me.OrderDateTextBox.Text) Then e.Command.Parameters("@OrderDate").Value = Me.OrderDateTextBox.Text

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

        e.Command.Parameters("@ExtraCharge1Amount").Value = Me.ExtraCharge1AmountTextBox.Text
        e.Command.Parameters("@ExtraCharge1Description").Value = Me.ExtraCharge1DescriptionTextBox.text
        e.Command.Parameters("@ExtraPay1Amount").Value = Me.ExtraPay1AmountTextBox.Text
        e.Command.Parameters("@ExtraPay1Description").Value = Me.ExtraPay1DescriptionTextBox.Text

        e.Command.Parameters("@CustomerContact").Value = Me.CustomerContactTextBox.Text

        e.Command.Parameters("@a1ActivityTime").Value = Me.AddActivityWebUserControl1.aActivityTimeTextBox.Text
        e.Command.Parameters("@a2ActivityTime").Value = Me.AddActivityWebUserControl2.aActivityTimeTextBox.Text
        e.Command.Parameters("@a3ActivityTime").Value = Me.AddActivityWebUserControl3.aActivityTimeTextBox.Text
        e.Command.Parameters("@a4ActivityTime").Value = Me.AddActivityWebUserControl4.aActivityTimeTextBox.Text

        e.Command.Parameters("@a1ActivityTimeEnd").Value = Me.AddActivityWebUserControl1.aActivityTimeEndTextBox.Text
        e.Command.Parameters("@a2ActivityTimeEnd").Value = Me.AddActivityWebUserControl2.aActivityTimeEndTextBox.Text
        e.Command.Parameters("@a3ActivityTimeEnd").Value = Me.AddActivityWebUserControl3.aActivityTimeEndTextBox.Text
        e.Command.Parameters("@a4ActivityTimeEnd").Value = Me.AddActivityWebUserControl4.aActivityTimeEndTextBox.Text



    End Sub


    Protected Sub SaveButton_Click(sender As Object, e As EventArgs) Handles SaveButton.Click

        Dim soid As Integer = 0
        If Request.QueryString("soid") = "" Then
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
            Catch ex As Exception

            Finally
                con.Close()
            End Try
        Else
            Me.OrdersSqlDataSource.Update()
            soid = Request.QueryString("soid")
        End If
        'UpdateCarrierInfo()
        Response.Redirect("NewOrderComplete.aspx?soid=" & soid.ToString)
    End Sub

    'Private Sub UpdateCarrierInfo(soid As Guid)
    '    Dim con As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("").ConnectionString)
    '    Try
    '        Dim cmd As New SqlCommand("UpdateCarrierFromShippingOrder", con)
    '        With cmd
    '            .CommandType = CommandType.StoredProcedure
    '            .Connection.Open()
    '            .Parameters.AddWithValue("@ShippingOrderID", soid)
    '            .ExecuteNonQuery()
    '        End With
    '    Catch ex As Exception
    '        'nothing
    '    Finally
    '        con.Close()
    '    End Try
    'End Sub

    Private Sub NewCarrierPopUpControl_Company_Updated(CompanyID As Integer) Handles NewCarrierPopUpControl.Company_Updated
        Me.CarrierIDHiddenField.Value = CompanyID
        Me.CarrierTextBox.Text = NewCarrierPopUpControl.GetCompanyNameFromSQL(CompanyID)
        LoadCarrierInfo(CompanyID)
        Me.CarrierSelectorUpdatePanel.Update()
    End Sub


    'Private Sub NewCustomerPopupControl_Company_Updated(CompanyID As Integer) Handles NewCustomerPopupControl.Company_Updated
    '    Me.CustomerIDHiddenField.Value = CompanyID
    '    Me.CustomerTextBox.Text = NewCustomerPopupControl.GetCompanyNameFromSQL(CompanyID)
    '    'LoadCustomerInfo(CompanyID)
    'End Sub

    Private Sub LoadOrder()

        Dim t As New ShippingOrderDataSet.DataTable1DataTable
        Using ta As New ShippingOrderDataSetTableAdapters.DataTable1TableAdapter
            ta.Fill(t, Request.QueryString("soid"))
        End Using
        Dim r As ShippingOrderDataSet.DataTable1Row = t.Rows(0)



        'If Not r.IsCustomerCompanyIDNull Then Me.CustomerIDHiddenField.Value = r.CustomerCompanyID
        'If Not r.IsCustomerCompanyNameNull Then Me.CustomerTextBox.Text = r.CustomerCompanyName
        Try
            If Not r.IsCustomerCompanyNameNull Then
                If Me.CustomerDropDownList.Items.Count = 0 Then Me.CustomerDropDownList.DataBind()

                Me.CustomerDropDownList.ClearSelection()
                Me.CustomerDropDownList.Items.FindByValue(r.CustomerCompanyID).Selected = True
            End If

        Catch ex As Exception

        End Try

        If Not r.IsCarrierCompanyIDNull Then Me.CarrierIDHiddenField.Value = r.CarrierCompanyID
        If Not r.IsCarrierCompanyNameNull Then Me.CarrierTextBox.Text = r.CarrierCompanyName
        If Not r.IsCarrierContactNull Then Me.CarrierContactTextBox.Text = r.CarrierContact
        If Not r.IsCarrierPhoneNull Then Me.CarrierPhoneTextBox.Text = r.CarrierPhone
        If Not r.IsCarrierFaxNull Then Me.CarrierFaxTextBox.Text = r.CarrierFax
        If Not r.IsCarrierEmailNull Then Me.EmailTextBox.Text = r.CarrierEmail
        If Not r.IsNotesNull Then Me.NotesTextBox.Text = r.Notes
        'If Not r.IsCustomerPONumberNull Then Me.CustomerPONumberTextBox.Text = r.CustomerPONumber
        If Not r.IsCustomerBillAmountNull Then Me.CustomerBillAmount.Text = Math.Round(Decimal.Parse(r.CustomerBillAmount), 2)
        If Not r.IsCarrierPayAmountNull Then Me.CarrierPayAmountTextBox.Text = Math.Round(Decimal.Parse(r.CarrierPayAmount), 2)
        If Not r.IsCarrierDriverNameNull Then Me.DriverNameTextBox.Text = r.CarrierDriverName
        If Not r.IsCarrierDriverCellNull Then Me.CellPhoneTextBox.Text = r.CarrierDriverCell
        'If Not r.IsCommodityTypenull then 
        If Not r.IsLoadTypeNull Then Me.LoadTypeDropDownList.SelectedValue = r.LoadType
        If Not r.IsTarpNull Then Me.TarpDropDownList.SelectedValue = r.Tarp
        If Not r.IsWeightNull Then Me.WeightTextBox.Text = r.Weight
        If Not r.IsStatusTypeNull Then Me.OrderStatusDropDownList.SelectedValue = r.StatusType
        If Not r.IsCitationContactNull Then Me.CitationContactTextBox.Text = r.CitationContact
        'If Me.ShippingOrderNumberTextBox.Text <> "[Auto]" Then If Not r.IsOrderNumbernull then  Me.ShippingOrderNumberTextBox.Text
        If Not r.IsOrderNumberNull Then Me.ShippingOrderNumberTextBox.Text = r.OrderNumber
        If Not r.IsOrderDateNull Then Me.OrderDateTextBox.Text = r.OrderDate.ToShortDateString

        'a1

        Me.AddActivityWebUserControl1.LoadValues(r, 1)
        Me.AddActivityWebUserControl2.LoadValues(r, 2)
        Me.AddActivityWebUserControl3.LoadValues(r, 3)
        Me.AddActivityWebUserControl4.LoadValues(r, 4)

        If Not r.IsExtraCharge1AmountNull Then Me.ExtraCharge1AmountTextBox.Text = r.ExtraCharge1Amount
        If Not r.IsExtraCharge1DescriptionNull Then Me.ExtraCharge1DescriptionTextBox.Text = r.ExtraCharge1Description
        If Not r.IsExtraPay1AmountNull Then Me.ExtraPay1AmountTextBox.Text = r.ExtraPay1Amount
        If Not r.IsExtraPay1DescriptionNull Then Me.ExtraPay1DescriptionTextBox.Text = r.ExtraPay1Description
        If Not r.IsCustomerContactNull Then Me.CustomerContactTextBox.Text = r.CustomerContact

        'If Not r.Isa1ActivityTypeNull Then Me.AddActivityWebUserControl1.aActivityTypeDropDownList.SelectedValue = r.a1ActivityType
        'If Not r.Isa1LocationCompanyIDNull Then Me.AddActivityWebUserControl1.aLocationIDHiddenField.Value = r.a1LocationCompanyID
        'If Not r.Isa1Address1Null Then Me.AddActivityWebUserControl1.aActivityAddress1TextBox.Text = r.a1Address1
        'If Not r.Isa1Address2Null Then Me.AddActivityWebUserControl1.aActivityAddress2TextBox.Text = r.a1Address2
        'If Not r.Isa1CityNull Then Me.AddActivityWebUserControl1.aActivityCityTextBox.Text = r.a1City
        'If Not r.Isa1StateNull Then Me.AddActivityWebUserControl1.aActivityStateDropdownList.SelectedValue = r.a1State
        'If Not r.Isa1PostalCodeNull Then Me.AddActivityWebUserControl1.aActivityPostalCodeTextBox.Text = r.a1PostalCode
        'If Not r.Isa1NotesNull Then Me.AddActivityWebUserControl1.aActivityNotesTextBox.Text = r.a1Notes
        'If Not r.Isa1CompletionDateNull Then Me.AddActivityWebUserControl1.aCompletionDateTextBox.Text = r.a1CompletionDate
        'If Not r.Isa1ActivityDateNull Then Me.AddActivityWebUserControl1.aActivityDateTextBox.Text = r.a1ActivityDate
        'If Not r.Isa1CommodityTypeNull Then Me.AddActivityWebUserControl1.aCommodityTypeDropDownList.SelectedValue = r.a1CommodityType
        'If Not r.Isa1PhoneNull Then Me.AddActivityWebUserControl1.aActivityPhoneTextBox.Text = r.a1Phone
        'If Not r.IsLocation1CompanyNameNull Then Me.AddActivityWebUserControl1.aLocationNameTextBox.text = r.Location1CompanyName

        ''a2
        'If Not r.Isa2ActivityTypeNull Then Me.AddActivityWebUserControl2.aActivityTypeDropDownList.SelectedValue = r.a2ActivityType
        'If Not r.Isa2LocationCompanyIDNull Then Me.AddActivityWebUserControl2.aLocationIDHiddenField.Value = r.a2LocationCompanyID
        'If Not r.Isa2Address1Null Then Me.AddActivityWebUserControl2.aActivityAddress1TextBox.Text = r.a2Address1
        'If Not r.Isa2Address2Null Then Me.AddActivityWebUserControl2.aActivityAddress2TextBox.Text = r.a2Address2
        'If Not r.Isa2CityNull Then Me.AddActivityWebUserControl2.aActivityCityTextBox.Text = r.a2City
        'If Not r.Isa2StateNull Then Me.AddActivityWebUserControl2.aActivityStateDropdownList.SelectedValue = r.a2State
        'If Not r.Isa2PostalCodeNull Then Me.AddActivityWebUserControl2.aActivityPostalCodeTextBox.Text = r.a2PostalCode
        'If Not r.Isa2NotesNull Then Me.AddActivityWebUserControl2.aActivityNotesTextBox.Text = r.a2Notes
        'If Not r.Isa2CompletionDateNull Then Me.AddActivityWebUserControl2.aCompletionDateTextBox.Text = r.a2CompletionDate
        'If Not r.Isa2ActivityDateNull Then Me.AddActivityWebUserControl2.aActivityDateTextBox.Text = r.a2ActivityDate
        'If Not r.Isa2CommodityTypeNull Then Me.AddActivityWebUserControl2.aCommodityTypeDropDownList.SelectedValue = r.a2CommodityType
        'If Not r.Isa2PhoneNull Then Me.AddActivityWebUserControl2.aActivityPhoneTextBox.Text = r.a2Phone

        ''a3
        'If Not r.Isa3ActivityTypeNull Then Me.AddActivityWebUserControl3.aActivityTypeDropDownList.SelectedValue = r.a3ActivityType
        'If Not r.Isa3LocationCompanyIDNull Then Me.AddActivityWebUserControl3.aLocationIDHiddenField.Value = r.a3LocationCompanyID
        'If Not r.Isa3Address1Null Then Me.AddActivityWebUserControl3.aActivityAddress1TextBox.Text = r.a3Address1
        'If Not r.Isa3Address2Null Then Me.AddActivityWebUserControl3.aActivityAddress2TextBox.Text = r.a3Address2
        'If Not r.Isa3CityNull Then Me.AddActivityWebUserControl3.aActivityCityTextBox.Text = r.a3City
        'If Not r.Isa3StateNull Then Me.AddActivityWebUserControl3.aActivityStateDropdownList.SelectedValue = r.a3State
        'If Not r.Isa3PostalCodeNull Then Me.AddActivityWebUserControl3.aActivityPostalCodeTextBox.Text = r.a3PostalCode
        'If Not r.Isa3NotesNull Then Me.AddActivityWebUserControl3.aActivityNotesTextBox.Text = r.a3Notes
        'If Not r.Isa3CompletionDateNull Then Me.AddActivityWebUserControl3.aCompletionDateTextBox.Text = r.a3CompletionDate
        'If Not r.Isa3ActivityDateNull Then Me.AddActivityWebUserControl3.aActivityDateTextBox.Text = r.a3ActivityDate
        'If Not r.Isa3CommodityTypeNull Then Me.AddActivityWebUserControl3.aCommodityTypeDropDownList.SelectedValue = r.a3CommodityType
        'If Not r.Isa3PhoneNull Then Me.AddActivityWebUserControl3.aActivityPhoneTextBox.Text = r.a3Phone

        ''a4
        'If Not r.Isa4ActivityTypeNull Then Me.AddActivityWebUserControl4.aActivityTypeDropDownList.SelectedValue = r.a4ActivityType
        'If Not r.Isa4LocationCompanyIDNull Then Me.AddActivityWebUserControl4.aLocationIDHiddenField.Value = r.a4LocationCompanyID
        'If Not r.Isa4Address1Null Then Me.AddActivityWebUserControl4.aActivityAddress1TextBox.Text = r.a4Address1
        'If Not r.Isa4Address2Null Then Me.AddActivityWebUserControl4.aActivityAddress2TextBox.Text = r.a4Address2
        'If Not r.Isa4CityNull Then Me.AddActivityWebUserControl4.aActivityCityTextBox.Text = r.a4City
        'If Not r.Isa4StateNull Then Me.AddActivityWebUserControl4.aActivityStateDropdownList.SelectedValue = r.a4State
        'If Not r.Isa4PostalCodeNull Then Me.AddActivityWebUserControl4.aActivityPostalCodeTextBox.Text = r.a4PostalCode
        'If Not r.Isa4NotesNull Then Me.AddActivityWebUserControl4.aActivityNotesTextBox.Text = r.a4Notes
        'If Not r.Isa4CompletionDateNull Then Me.AddActivityWebUserControl4.aCompletionDateTextBox.Text = r.a4CompletionDate
        'If Not r.Isa4ActivityDateNull Then Me.AddActivityWebUserControl4.aActivityDateTextBox.Text = r.a4ActivityDate
        'If Not r.Isa4CommodityTypeNull Then Me.AddActivityWebUserControl4.aCommodityTypeDropDownList.SelectedValue = r.a4CommodityType
        'If Not r.Isa4PhoneNull Then Me.AddActivityWebUserControl4.aActivityPhoneTextBox.Text = r.a4Phone
    End Sub

    Private Sub OrdersSqlDataSource_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles OrdersSqlDataSource.Updating
        e.Command.Parameters("@ShippingOrderID").Value = Request.QueryString("soid")
        e.Command.Parameters("@CustomerCompanyID").Value = Me.CustomerDropDownList.SelectedValue 'Me.CustomerIDHiddenField.Value
        If Me.CarrierIDHiddenField.Value <> "" Then e.Command.Parameters("@CarrierCompanyID").Value = Me.CarrierIDHiddenField.Value
        e.Command.Parameters("@CarrierContact").Value = Me.CarrierContactTextBox.Text
        e.Command.Parameters("@CarrierPhone").Value = Me.CarrierPhoneTextBox.Text
        e.Command.Parameters("@CarrierFax").Value = Me.CarrierFaxTextBox.Text
        e.Command.Parameters("@CarrierEmail").Value = Me.EmailTextBox.Text
        e.Command.Parameters("@Notes").Value = Me.NotesTextBox.Text
        'e.Command.Parameters("@CustomerPONumber").Value = Me.CustomerPONumberTextBox.Text
        e.Command.Parameters("@CustomerBillAmount").Value = Me.CustomerBillAmount.Text
        e.Command.Parameters("@CarrierPayAmount").Value = Me.CarrierPayAmountTextBox.Text
        e.Command.Parameters("@CarrierDriverName").Value = Me.DriverNameTextBox.Text
        e.Command.Parameters("@CarrierDriverCell").Value = Me.CellPhoneTextBox.Text
        e.Command.Parameters("@CommodityType").Value = Nothing
        If Me.LoadTypeDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@LoadType").Value = Me.LoadTypeDropDownList.SelectedValue
        If Me.TarpDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@Tarp").Value = Me.TarpDropDownList.SelectedValue
        e.Command.Parameters("@Weight").Value = Me.WeightTextBox.Text
        If Me.OrderStatusDropDownList.SelectedIndex > -1 Then e.Command.Parameters("@StatusType").Value = Me.OrderStatusDropDownList.SelectedValue
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
        If IsDate(Me.OrderDateTextBox.Text) AndAlso Not IsNumeric(Me.ShippingOrderNumberTextBox.Text) AndAlso Me.OrderStatusDropDownList.SelectedValue <> "Pending" AndAlso Me.OrderStatusDropDownList.SelectedValue <> "Cancelled" Then
            e.Command.Parameters("@OrderNumber").Value = Me.GetNextOrderNumber
            e.Command.Parameters("@OrderDate").Value = Me.OrderDateTextBox.Text
        ElseIf IsDate(Me.OrderDateTextBox.Text) AndAlso IsNumeric(Me.ShippingOrderNumberTextBox.Text) Then
            e.Command.Parameters("@OrderNumber").Value = Me.ShippingOrderNumberTextBox.Text
            e.Command.Parameters("@OrderDate").Value = Me.OrderDateTextBox.Text
        End If



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
        e.Command.Parameters("@ExtraCharge1Description").Value = Me.ExtraCharge1DescriptionTextBox.text
        e.Command.Parameters("@ExtraPay1Amount").Value = Me.ExtraPay1AmountTextBox.Text
        e.Command.Parameters("@ExtraPay1Description").Value = Me.ExtraPay1DescriptionTextBox.Text

        e.Command.Parameters("@CustomerContact").Value = Me.CustomerContactTextBox.Text


        e.Command.Parameters("@a1ActivityTimeEnd").Value = Me.AddActivityWebUserControl1.aActivityTimeEndTextBox.Text
        e.Command.Parameters("@a2ActivityTimeEnd").Value = Me.AddActivityWebUserControl2.aActivityTimeEndTextBox.Text
        e.Command.Parameters("@a3ActivityTimeEnd").Value = Me.AddActivityWebUserControl3.aActivityTimeEndTextBox.Text
        e.Command.Parameters("@a4ActivityTimeEnd").Value = Me.AddActivityWebUserControl4.aActivityTimeEndTextBox.Text



    End Sub

    Private Sub LoadCustomerInfo(id As Integer)
        'nothing to do
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

                'If Not r.IsContactNull Then Me.CarrierContactTextBox.Text = r.Contact
                'If Not r.IsemailNull Then Me.EmailTextBox.Text = r.email
                'If Not r.IsFaxNull Then Me.CarrierFaxTextBox.Text = r.Fax
                'If Not r.IsPhoneNull Then Me.CarrierPhoneTextBox.Text = r.Phone

                If Not r.IsCarrierContactNull Then Me.CarrierContactTextBox.Text = r.CarrierContact
                If Not r.IsCarrierPhoneNull Then Me.CarrierPhoneTextBox.Text = r.CarrierPhone
                If Not r.IsCarrierFaxNull Then Me.CarrierFaxTextBox.Text = r.CarrierFax
                If Not r.IsCarrierEmailNull Then Me.EmailTextBox.Text = r.CarrierEmail
                If Not r.IsCarrierDriverNameNull Then Me.DriverNameTextBox.Text = r.CarrierDriverName
                If Not r.IsCarrierDriverCellNull Then Me.CellPhoneTextBox.Text = r.CarrierDriverCell

                'If Not r.IssAddress1Null Then Me.ActivityAddress1TextBox.Text = r.sAddress1
                'If Not r.IssAddress2Null Then Me.ActivityAddress2TextBox.Text = r.sAddress2
                'If Not r.IssCityNull Then Me.ActivityCityTextBox.Text = r.sCity
                'If Not r.IssPostalCodeNull Then Me.ActivityPostalCodeTextBox.Text = r.sPostalCode
                'If Not r.IsContactNull Then Me.ActivityContactTextBox.Text = r.Contact
                'If Not r.IsPhoneNull Then Me.ActivityPhoneTextBox.Text = r.Phone
                'If Not r.IssStateNull Then
                '    Me.ActivityStateDropdownList.ClearSelection()
                '    Me.ActivityStateDropdownList.Items.FindByValue(r.sState).Selected = True
                'End If
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

    Protected Sub CancelButton_Click(sender As Object, e As EventArgs) Handles CancelButton.Click
        Response.Redirect("~/Orders.aspx")
    End Sub
End Class