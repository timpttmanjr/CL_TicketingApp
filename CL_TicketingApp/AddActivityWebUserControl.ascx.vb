Imports System.Data.SqlClient

Public Class AddActivityWebUserControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Me.LocationTextBox.Attributes.Add("onclientitemselected", Me.LocationTextBox.ClientID & "LocationItemSelected")
        End If
    End Sub

    Public ReadOnly Property aActivityTypeDropDownList As DropDownList
        Get
            Return Me.ActivityTypeDropDownList
        End Get
    End Property

    'Public ReadOnly Property aActivityLocationDropDownList As DropDownList
    '    Get
    '        Return ActivityLocationDropDownList
    '    End Get
    'End Property

    Public ReadOnly Property aLocationTextBox As TextBox
        Get
            Return Me.LocationTextBox
        End Get
    End Property

    Public ReadOnly Property aLocationIDTextBox As TextBox
        Get
            Return Me.LocationIDTextBox
        End Get
    End Property

    Public ReadOnly Property LocationID As Integer
        Get
            Return Me.GetIDFromName(Me.LocationTextBox.Text)
        End Get
    End Property


    Public ReadOnly Property aActivityAddress1TextBox As TextBox
        Get
            Return ActivityAddress1TextBox
        End Get
    End Property
    Public ReadOnly Property aActivityAddress2TextBox As TextBox
        Get
            Return ActivityAddress2TextBox
        End Get
    End Property
    Public ReadOnly Property aActivityCityTextBox As TextBox
        Get
            Return ActivityCityTextBox
        End Get
    End Property

    Public ReadOnly Property aActivityStateDropdownList As DropDownList
        Get
            Return ActivityStateDropdownList
        End Get
    End Property

    Public ReadOnly Property aActivityPostalCodeTextBox As TextBox
        Get
            Return ActivityPostalCodeTextBox
        End Get
    End Property

    Public ReadOnly Property aActivityContactTextBox As TextBox
        Get
            Return ActivityContactTextBox
        End Get
    End Property

    Public ReadOnly Property aActivityPhoneTextBox As TextBox
        Get
            Return ActivityPhoneTextBox
        End Get
    End Property
    'Public ReadOnly Property aCommodityTypeDropDownList As DropDownList
    '    Get
    '        Return CommodityTypeDropDownList
    '    End Get
    'End Property
    Public ReadOnly Property aCommodityTypeTextBox As TextBox
        Get
            Return CommodityTypeTextBox
        End Get
    End Property
    Public ReadOnly Property aActivityDateTextBox As TextBox
        Get
            Return ActivityDateTextBox
        End Get
    End Property
    Public ReadOnly Property aActivityNotesTextBox As TextBox
        Get
            Return ActivityNotesTextBox
        End Get
    End Property
    Public ReadOnly Property aCompletionDateTextBox As TextBox
        Get
            Return CompletionDateTextBox
        End Get
    End Property

    Public ReadOnly Property aContactTextBox As TextBox
        Get
            Return ActivityContactTextBox
        End Get
    End Property

    Public ReadOnly Property aActivityTimeTextBox As TextBox
        Get
            Return ActivityTimeTextBox
        End Get
    End Property
    Public ReadOnly Property aActivityTimeEndTextBox As TextBox
        Get
            Return ActivityTimeEndTextBox
        End Get
    End Property
    Public Sub LoadValues(r As ShippingOrderDataSet.DataTable1Row, ActivityRowID As Integer)

        Select Case ActivityRowID
            Case 1
                If Not r.Isa1ActivityTypeNull Then Me.ActivityTypeDropDownList.SelectedValue = r.a1ActivityType
                If Not r.Isa1LocationCompanyIDNull Then Me.LocationIDTextBox.text = r.a1LocationCompanyID
                If Not r.Isa1Address1Null Then Me.ActivityAddress1TextBox.Text = r.a1Address1
                If Not r.Isa1Address2Null Then Me.ActivityAddress2TextBox.Text = r.a1Address2
                If Not r.Isa1CityNull Then Me.ActivityCityTextBox.Text = r.a1City
                If Not r.Isa1StateNull Then Me.ActivityStateDropdownList.SelectedValue = r.a1State
                If Not r.Isa1PostalCodeNull Then Me.ActivityPostalCodeTextBox.Text = r.a1PostalCode
                If Not r.Isa1NotesNull Then Me.ActivityNotesTextBox.Text = r.a1Notes
                If Not r.Isa1CompletionDateNull Then Me.CompletionDateTextBox.Text = r.a1CompletionDate
                If Not r.Isa1ActivityDateNull Then Me.ActivityDateTextBox.Text = r.a1ActivityDate
                'If Not r.Isa1CommodityTypeNull Then Me.CommodityTypeDropDownList.SelectedValue = r.a1CommodityType
                If Not r.Isa1CommodityTypeNull Then Me.CommodityTypeTextBox.Text = r.a1CommodityType
                If Not r.Isa1PhoneNull Then Me.ActivityPhoneTextBox.Text = r.a1Phone
                If Not r.IsLocation1CompanyNameNull Then Me.LocationTextBox.Text = r.Location1CompanyName
                If Not r.Isa1ContactNull Then Me.ActivityContactTextBox.Text = r.a1Contact
                If Not r.Isa1ActivityTimeNull Then Me.ActivityTimeTextBox.Text = r.a1ActivityTime

                If Not r.Isa1ActivityTimeEndNull Then Me.ActivityTimeEndTextBox.Text = r.a1ActivityTimeEnd

            Case 2
                If Not r.Isa2ActivityTypeNull Then Me.ActivityTypeDropDownList.SelectedValue = r.a2ActivityType
                If Not r.Isa2LocationCompanyIDNull Then Me.LocationIDTextBox.text = r.a2LocationCompanyID
                If Not r.Isa2Address1Null Then Me.ActivityAddress1TextBox.Text = r.a2Address1
                If Not r.Isa2Address2Null Then Me.ActivityAddress2TextBox.Text = r.a2Address2
                If Not r.Isa2CityNull Then Me.ActivityCityTextBox.Text = r.a2City
                If Not r.Isa2StateNull Then Me.ActivityStateDropdownList.SelectedValue = r.a2State
                If Not r.Isa2PostalCodeNull Then Me.ActivityPostalCodeTextBox.Text = r.a2PostalCode
                If Not r.Isa2NotesNull Then Me.ActivityNotesTextBox.Text = r.a2Notes
                If Not r.Isa2CompletionDateNull Then Me.CompletionDateTextBox.Text = r.a2CompletionDate
                If Not r.Isa2ActivityDateNull Then Me.ActivityDateTextBox.Text = r.a2ActivityDate
                'If Not r.Isa2CommodityTypeNull Then Me.CommodityTypeDropDownList.SelectedValue = r.a2CommodityType
                If Not r.Isa2CommodityTypeNull Then Me.CommodityTypeTextBox.Text = r.a2CommodityType
                If Not r.Isa2PhoneNull Then Me.ActivityPhoneTextBox.Text = r.a2Phone
                If Not r.IsLocation2CompanyNameNull Then Me.LocationTextBox.Text = r.Location2CompanyName
                If Not r.Isa2ContactNull Then Me.ActivityContactTextBox.Text = r.a2Contact
                If Not r.Isa2ActivityTimeNull Then Me.ActivityTimeTextBox.Text = r.a2ActivityTime
                If Not r.Isa2ActivityTimeEndNull Then Me.ActivityTimeEndTextBox.Text = r.a2ActivityTimeEnd

            Case 3
                If Not r.Isa3ActivityTypeNull Then Me.aActivityTypeDropDownList.SelectedValue = r.a3ActivityType
                If Not r.Isa3LocationCompanyIDNull Then Me.LocationIDTextBox.text = r.a3LocationCompanyID
                If Not r.Isa3Address1Null Then Me.ActivityAddress1TextBox.Text = r.a3Address1
                If Not r.Isa3Address2Null Then Me.ActivityAddress2TextBox.Text = r.a3Address2
                If Not r.Isa3CityNull Then Me.ActivityCityTextBox.Text = r.a3City
                If Not r.Isa3StateNull Then Me.ActivityStateDropdownList.SelectedValue = r.a3State
                If Not r.Isa3PostalCodeNull Then Me.ActivityPostalCodeTextBox.Text = r.a3PostalCode
                If Not r.Isa3NotesNull Then Me.ActivityNotesTextBox.Text = r.a3Notes
                If Not r.Isa3CompletionDateNull Then Me.CompletionDateTextBox.Text = r.a3CompletionDate
                If Not r.Isa3ActivityDateNull Then Me.ActivityDateTextBox.Text = r.a3ActivityDate
                'If Not r.Isa3CommodityTypeNull Then Me.CommodityTypeDropDownList.SelectedValue = r.a3CommodityType
                If Not r.Isa3CommodityTypeNull Then Me.CommodityTypeTextBox.Text = r.a3CommodityType
                If Not r.Isa3PhoneNull Then Me.ActivityPhoneTextBox.Text = r.a3Phone
                If Not r.IsLocation3CompanyNameNull Then Me.LocationTextBox.Text = r.Location3CompanyName
                If Not r.Isa3ContactNull Then Me.ActivityContactTextBox.Text = r.a3Contact
                If Not r.Isa3ActivityTimeNull Then Me.ActivityTimeTextBox.Text = r.a3ActivityTime
                If Not r.Isa3ActivityTimeEndNull Then Me.ActivityTimeEndTextBox.Text = r.a3ActivityTimeEnd

            Case 4
                If Not r.Isa4ActivityTypeNull Then Me.ActivityTypeDropDownList.SelectedValue = r.a4ActivityType
                If Not r.Isa4LocationCompanyIDNull Then Me.LocationIDTextBox.text = r.a4LocationCompanyID
                If Not r.Isa4Address1Null Then Me.ActivityAddress1TextBox.Text = r.a4Address1
                If Not r.Isa4Address2Null Then Me.ActivityAddress2TextBox.Text = r.a4Address2
                If Not r.Isa4CityNull Then Me.ActivityCityTextBox.Text = r.a4City
                If Not r.Isa4StateNull Then Me.ActivityStateDropdownList.SelectedValue = r.a4State
                If Not r.Isa4PostalCodeNull Then Me.ActivityPostalCodeTextBox.Text = r.a4PostalCode
                If Not r.Isa4NotesNull Then Me.ActivityNotesTextBox.Text = r.a4Notes
                'If Not r.Isa4CompletionDateNull Then Me.CompletionDateTextBox.Text = r.a4CompletionDate
                If Not r.Isa4ActivityDateNull Then Me.ActivityDateTextBox.Text = r.a4ActivityDate
                'If Not r.Isa4CommodityTypeNull Then Me.CommodityTypeDropDownList.SelectedValue = r.a4CommodityType
                If Not r.Isa4CommodityTypeNull Then Me.CommodityTypeTextBox.Text = r.a4CommodityType
                If Not r.Isa4PhoneNull Then Me.ActivityPhoneTextBox.Text = r.a4Phone
                If Not r.IsLocation4CompanyNameNull Then Me.LocationTextBox.Text = r.Location4CompanyName
                If Not r.Isa4ContactNull Then Me.ActivityContactTextBox.Text = r.a4Contact
                If Not r.Isa4ActivityTimeNull Then Me.ActivityTimeTextBox.Text = r.a4ActivityTime
                If Not r.Isa4ActivityTimeEndNull Then Me.ActivityTimeEndTextBox.Text = r.a4ActivityTimeEnd

        End Select
    End Sub

    'Private Sub LoadCompanyInfo(id As Integer)
    '    Try
    '        Dim t As New ShippingOrderDataSet.CompanySelectDataTable
    '        Using ta As New ShippingOrderDataSetTableAdapters.CompanySelectTableAdapter
    '            ta.Fill(t, id)
    '        End Using
    '        If t.Rows.Count > 0 Then
    '            Dim r As ShippingOrderDataSet.CompanySelectRow = t.Rows(0)
    '            If Not r.IssAddress1Null Then Me.ActivityAddress1TextBox.Text = r.sAddress1
    '            If Not r.IssAddress2Null Then Me.ActivityAddress2TextBox.Text = r.sAddress2
    '            If Not r.IssCityNull Then Me.ActivityCityTextBox.Text = r.sCity
    '            If Not r.IssPostalCodeNull Then Me.ActivityPostalCodeTextBox.Text = r.sPostalCode
    '            If Not r.IsContactNull Then Me.ActivityContactTextBox.Text = r.Contact
    '            If Not r.IsPhoneNull Then Me.ActivityPhoneTextBox.Text = r.Phone
    '            If Not r.IssStateNull Then
    '                Me.ActivityStateDropdownList.ClearSelection()
    '                Try
    '                    Me.ActivityStateDropdownList.Items.FindByValue(r.sState).Selected = True
    '                Catch ex As Exception
    '                    '?
    '                End Try
    '            End If
    '        End If
    '    Catch ex As Exception

    '    End Try
    '    Me.ActivityUpdatePanel.Update()
    'End Sub


    Private Sub NewLocationPopupControl_Company_Updated(CompanyID As Integer) Handles NewLocationPopupControl.Company_Updated
        'Me.LocationIDHiddenField.Value = CompanyID
        Me.LocationIDTextBox.text = CompanyID
        Me.LocationTextBox.Text = NewLocationPopUpControl.GetCompanyNameFromSQL(CompanyID)
        LoadCompanyInfo(Integer.Parse(Me.LocationIDTextBox.Text))


    End Sub

    Protected Sub LocationTextBox_TextChanged(sender As Object, e As EventArgs) Handles LocationTextBox.TextChanged
        Me.LocationIDTextBox.Text = GetIDFromName(Me.LocationTextBox.Text)
        If Me.LocationIDTextBox.text = "" Then Me.LocationIDTextBox.text = -1
        If Me.LocationIDTextBox.text < 1 Then


            'Me.LocationTextBox.Text = ""

            'get the text
            Dim s As String = Me.LocationTextBox.Text

            'clear the box
            Me.LocationTextBox.Text = ""

            'popup the editor
            Me.NewLocationPopUpControl.CompanyName = s
            Me.NewLocationPopUpControl.isCustomer = False
            Me.NewLocationPopUpControl.isVendor = False
            Me.NewLocationPopUpControl.ShowPopup()



        Else
            LoadCompanyInfo(Integer.Parse(Me.LocationIDTextBox.Text))

            Me.LocationTextBox.Focus()
        End If
    End Sub


    Private Function GetIDFromName(CompanyName As String) As Integer
        Dim i As Integer = 0

        Dim conn As SqlConnection = New SqlConnection
        Try
            conn.ConnectionString = ConfigurationManager _
                 .ConnectionStrings("DefaultConnection").ConnectionString
            Dim cmd As SqlCommand = New SqlCommand
            cmd.CommandText = "select top 1 id from company where  (companyname + ' (' + isnull(sCity,'Unknown City') + ', ' + isnull(sState,'Unknown State') + ')' = '" + CompanyName + "' or companyname = '" + CompanyName + "') and (isnull(Vendor,0) = 0 and isnull(Customer,0) = 0 and isnull(disabled,0) = 0)"
            cmd.Connection = conn
            conn.Open()
            i = cmd.ExecuteScalar

        Catch ex As Exception
            Elmah.ErrorSignal.FromCurrentContext().Raise(ex)

            i = -1
        Finally
            conn.Close()
        End Try
        Return i
    End Function


    Public Sub SetTabIndex(TabIndexFactor As Integer)

        Me.ActivityTypeDropDownList.TabIndex = TabIndexFactor + 1
        Me.LocationTextBox.TabIndex = TabIndexFactor + 2
        Me.LocationIDTextBox.TabIndex = TabIndexFactor + 3
        Me.ActivityAddress1TextBox.TabIndex = TabIndexFactor + 4
        Me.ActivityAddress2TextBox.TabIndex = TabIndexFactor + 5
        Me.ActivityCityTextBox.TabIndex = TabIndexFactor + 6
        Me.ActivityStateDropdownList.TabIndex = TabIndexFactor + 7
        Me.ActivityPostalCodeTextBox.TabIndex = TabIndexFactor + 8
        Me.ActivityContactTextBox.TabIndex = TabIndexFactor + 9
        Me.ActivityPhoneTextBox.TabIndex = TabIndexFactor + 10
        'Me.CommodityTypeDropDownList.TabIndex = TabIndexFactor + 11
        Me.CommodityTypeTextBox.TabIndex = TabIndexFactor + 11

        Me.ActivityDateTextBox.TabIndex = TabIndexFactor + 12
        Me.ActivityTimeTextBox.TabIndex = TabIndexFactor + 13
        Me.ActivityNotesTextBox.TabIndex = TabIndexFactor + 14
        'Me.CompletionDateTextBox.TabIndex = TabIndexFactor + 15
        'For Each c As Control In Me.ActivityUpdatePanel.Controls
        '    If TypeOf c Is WebControl Or TypeOf c Is DropDownList Then
        '        Dim ti As Integer
        '        If CType(c, WebControl).TabIndex > -1 Then
        '            ti = CType(c, WebControl).TabIndex
        '        Else
        '            ti = 0
        '        End If
        '        CType(c, WebControl).TabIndex = ti + TabIndexFactor
        '    End If
        'Next
    End Sub
    Private Sub LoadCompanyInfo(id As Integer)
        Try
            Dim getdefaults As Boolean = False

            Dim t As New ShippingOrderDataSet.LocationInfoFromLastOrderDataTable
            Using ta As New ShippingOrderDataSetTableAdapters.LocationInfoFromLastOrderTableAdapter
                ta.Fill(t, id)
            End Using
            If t.Rows.Count > 0 Then
                Dim r As ShippingOrderDataSet.LocationInfoFromLastOrderRow = t.Rows(0)
                If Not r.Isa1Address1Null Then Me.ActivityAddress1TextBox.Text = r.a1Address1
                If Not r.Isa1Address2Null Then Me.ActivityAddress2TextBox.Text = r.a1Address2
                If Not r.Isa1CityNull Then Me.ActivityCityTextBox.Text = r.a1City
                If Not r.Isa1PostalCodeNull Then Me.ActivityPostalCodeTextBox.Text = r.a1PostalCode
                If Not r.Isa1ContactNull Then Me.ActivityContactTextBox.Text = r.a1Contact
                If Not r.Isa1PhoneNull Then Me.ActivityPhoneTextBox.Text = r.a1Phone
                If Not r.Isa1StateNull Then
                    Me.ActivityStateDropdownList.ClearSelection()
                    Try
                        Me.ActivityStateDropdownList.Items.FindByValue(r.a1State.ToUpper).Selected = True
                    Catch ex As Exception
                        Elmah.ErrorSignal.FromCurrentContext().Raise(ex)

                    End Try

                End If
            Else
                getdefaults = True
            End If

            If getdefaults Then
                Dim t1 As New ShippingOrderDataSet.CompanySelectDataTable
                Using ta1 As New ShippingOrderDataSetTableAdapters.CompanySelectTableAdapter

                    ta1.Fill(t1, id)
                End Using
                If t1.Rows.Count > 0 Then
                    Dim r As ShippingOrderDataSet.CompanySelectRow = t1.Rows(0)

                    If Not r.IssAddress1Null Then Me.ActivityAddress1TextBox.Text = r.sAddress1
                    If Not r.IssAddress2Null Then Me.ActivityAddress2TextBox.Text = r.sAddress2
                    If Not r.IssCityNull Then Me.ActivityCityTextBox.Text = r.sCity
                    If Not r.IssPostalCodeNull Then Me.ActivityPostalCodeTextBox.Text = r.sPostalCode
                    If Not r.IsContactNull Then Me.ActivityContactTextBox.Text = r.Contact
                    If Not r.IsPhoneNull Then Me.ActivityPhoneTextBox.Text = r.Phone
                    If Not r.IssStateNull Then
                        Me.ActivityStateDropdownList.ClearSelection()
                        Me.ActivityStateDropdownList.Items.FindByValue(r.sState.ToUpper).Selected = True
                    End If

                End If

            End If


        Catch ex As Exception
            Elmah.ErrorSignal.FromCurrentContext().Raise(ex)

        End Try
        Me.ActivityUpdatePanel.Update()
    End Sub

End Class