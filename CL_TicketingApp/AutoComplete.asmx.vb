Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.Services
Imports System.Data
Imports System.Data.SqlClient

Namespace CitationLogistics
    <WebService([Namespace]:="http://tempuri.org/")> _
    <WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
    <System.ComponentModel.ToolboxItem(False)> _
    <System.Web.Script.Services.ScriptService> _
    Public Class AutoComplete
        Inherits System.Web.Services.WebService
        <WebMethod> _
        Public Shared Function Customers(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
            Dim conn As SqlConnection = New SqlConnection
            conn.ConnectionString = ConfigurationManager _
                 .ConnectionStrings("DefaultConnection").ConnectionString
            Dim cmd As SqlCommand = New SqlCommand
            cmd.CommandText = "select id, companyname from company where isnull(disabled,0) = 0 and CompanyName like '%' + @SearchText + '%'"
            cmd.Parameters.AddWithValue("@SearchText", prefixText)
            cmd.Connection = conn
            conn.Open()
            Dim c As List(Of String) = New List(Of String)
            Dim sdr As SqlDataReader = cmd.ExecuteReader
            While sdr.Read
                c.Add(sdr("CompanyName").ToString)
            End While
            conn.Close()
            Return c
        End Function
    End Class
End Namespace
