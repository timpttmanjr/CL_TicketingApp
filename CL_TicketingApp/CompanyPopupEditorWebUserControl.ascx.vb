Imports System.Data.SqlClient

Public Class CompanyPopupEditorWebUserControl
    Inherits System.Web.UI.UserControl

    'Private Helper As clHelpers

    Public Property isVendor As Boolean
        Get
            Return CType(FormView1.FindControl("VendorCheckBox"), CheckBox).Checked
        End Get
        Set(value As Boolean)
            CType(FormView1.FindControl("VendorCheckBox"), CheckBox).Checked = value
        End Set
    End Property
    Public Property isCustomer As Boolean
        Get
            Return CType(FormView1.FindControl("CustomerCheckBox"), CheckBox).Checked
        End Get
        Set(value As Boolean)
            CType(FormView1.FindControl("CustomerCheckBox"), CheckBox).Checked = value
        End Set
    End Property
  
    Public Property CompanyName As String
        Get
            Return CType(formview1.findcontrol("CompanyNameTextBox"), textbox).text
        End Get
        Set(value As String)
            CType(formview1.findcontrol("CompanyNameTextBox"), textbox).text = value
        End Set
    End Property

    Public Event NewCompany_Inserted(ByVal CompanyID As Integer)
    Public Event NewCompany_Canceled()
    Public Event NewCompany_UpdateError(ByVal ErrorMessage As String)

    Public Property CompanyID As Integer
    'Public Property CompanyName As String


    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '    Helper = New clHelpers

    'End Sub


    Public Sub SaveCompany()
        If Me.FormView1.CurrentMode = FormViewMode.Insert Then
            Me.FormView1.InsertItem(True)
        ElseIf Me.FormView1.CurrentMode = FormViewMode.Edit Then
            Me.FormView1.UpdateItem(True)
        End If
    End Sub

    Private Sub CompanyDataSource_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles CompanyDataSource.Inserted
        CompanyID = GetCompanyIDFromSQL(e.Command.Parameters("@CompanyName").Value)
        'CompanyName = e.Command.Parameters("@CompanyName").Value
        RaiseEvent NewCompany_Inserted(CompanyID)
        'Me.ModalPopupExtender1.Hide()

    End Sub

    Public Shared Function GetCompanyIDFromSQL(CompanyName As String) As Integer
        Dim i As Integer
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Try
            Dim cmd As New SqlCommand("[CompanySelectByName]", con)
            With cmd
                .CommandType = CommandType.StoredProcedure
                .Parameters.AddWithValue("@CompanyName", CompanyName)
                .Connection.Open()

                i = .ExecuteScalar
            End With
        Catch ex As Exception
            i = -1
        Finally
            con.Close()
        End Try
        Return i
    End Function




    Private Sub CompanyDataSource_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles CompanyDataSource.Inserting

        If GetCompanyIDFromSQL(e.Command.Parameters("@CompanyName").Value) > 0 Then

            e.Cancel = True
            RaiseEvent NewCompany_UpdateError("Company already exists")
            'Me.ModalPopupExtender1.Show()
        Else
            If isVendor Then
                e.Command.Parameters("@Vendor").Value = True
            Else
                e.Command.Parameters("@Vendor").Value = False
            End If
            If isCustomer Then
                e.Command.Parameters("@Customer").Value = True
            Else
                e.Command.Parameters("@Customer").Value = False
            End If
            'Me.ModalPopupExtender1.Hide()
        End If
    End Sub
End Class