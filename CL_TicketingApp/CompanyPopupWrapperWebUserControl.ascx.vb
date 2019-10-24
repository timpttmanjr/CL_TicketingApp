Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.Services
Imports System.Data
Imports System.Data.SqlClient
Public Class CompanyPopupWrapperWebUserControl
    Inherits System.Web.UI.UserControl

    Public Property isVendor As Boolean
        Get
            Return Me.CompanyPopupEditorWebUserControl1.isVendor
        End Get
        Set(value As Boolean)
            Me.CompanyPopupEditorWebUserControl1.isVendor = value
        End Set
    End Property
    Public Property isCustomer As Boolean
        Get
            Return Me.CompanyPopupEditorWebUserControl1.isCustomer
        End Get
        Set(value As Boolean)
            Me.CompanyPopupEditorWebUserControl1.isCustomer = value
        End Set
    End Property

    Public Property CompanyName As String
        Get
            Return Me.CompanyPopupEditorWebUserControl1.CompanyName
        End Get
        Set(value As String)
            Me.CompanyPopupEditorWebUserControl1.CompanyName = value
        End Set
    End Property

    Public Event Company_Updated(ByVal CompanyID As Integer)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Me.CompanyPopupEditorWebUserControl1.isVendor = isVendor
        'Me.CompanyPopupEditorWebUserControl1.isCustomer = isCustomer
    End Sub

    Private Sub CompanyPopupEditorWebUserControl_NewCompany_Canceled() Handles CompanyPopupEditorWebUserControl1.NewCompany_Canceled
        Me.CompanyModalPopupExtender.Show()
    End Sub

    Protected Sub CompanyPopupEditorWebUserControl_NewCompany_Inserted(ByVal companyid As Integer) Handles CompanyPopupEditorWebUserControl1.NewCompany_Inserted
        'Response.Write(companyid.ToString)
        RaiseEvent Company_Updated(companyid)
        Me.CompanyModalPopupExtender.Hide()
    End Sub


    '    <System.Web.Script.Services.ScriptMethod(), _
    'System.Web.Services.WebMethod()> _
    '    Public Shared Function SearchCustomers(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
    '        Dim conn As SqlConnection = New SqlConnection
    '        conn.ConnectionString = ConfigurationManager _
    '             .ConnectionStrings("DefaultConnection").ConnectionString
    '        Dim cmd As SqlCommand = New SqlCommand
    '        cmd.CommandText = "select id, companyname from company where CompanyName like '%' + @SearchText + '%'"
    '        cmd.Parameters.AddWithValue("@SearchText", prefixText)
    '        cmd.Connection = conn
    '        conn.Open()
    '        Dim c As List(Of String) = New List(Of String)
    '        Dim sdr As SqlDataReader = cmd.ExecuteReader
    '        While sdr.Read
    '            c.Add(sdr("CompanyName").ToString)
    '        End While
    '        conn.Close()
    '        Return c
    '    End Function

    Protected Sub SaveButton_Click(sender As Object, e As EventArgs)
        Me.CompanyPopupEditorWebUserControl1.SaveCompany()
    End Sub

    Private Sub CompanyPopupEditorWebUserControl_NewCompany_UpdateError(ErrorMessage As String) Handles CompanyPopupEditorWebUserControl1.NewCompany_UpdateError
        Me.MessageLabel.Text = ErrorMessage
        Me.CompanyModalPopupExtender.Show()
    End Sub

    Public Function GetCompanyNameFromSQL(CompanyID As Integer) As String
        Dim s As String
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Try
            Dim cmd As New SqlCommand("select top 1 CompanyName from company where id = " & CompanyID, con)
            With cmd
                .Connection.Open()
                .CommandType = CommandType.Text
                s = .ExecuteScalar
            End With
        Catch ex As Exception
            s = "Error"
        Finally
            con.Close()
        End Try
        Return s
    End Function

    Public Property CompanyID As Integer
    'Public Property CompanyName As String

    Public Sub ShowPopup()
        Me.CompanyModalPopupExtender.Show()
    End Sub
End Class