Imports System.Data.SqlClient

Public Class CompanyEditor
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack And Request.QueryString("coid") <> "" Then
            Me.DetailsView1.ChangeMode(DetailsViewMode.Edit)
        End If
    End Sub

    Private Sub DetailsView1_ItemInserted(sender As Object, e As DetailsViewInsertedEventArgs) Handles DetailsView1.ItemInserted
        Response.Redirect("~/Companies.aspx")
    End Sub

    Private Sub DetailsView1_ItemUpdated(sender As Object, e As DetailsViewUpdatedEventArgs) Handles DetailsView1.ItemUpdated
        If UpdateAddresses(Integer.Parse(Request.QueryString("coid"))) Then
            Response.Redirect("~/Companies.aspx")
        End If

    End Sub

    Public Function UpdateAddresses(companyid As Integer) As Boolean
        Dim b As Boolean = False
        Dim conn As SqlConnection = New SqlConnection
        Try
            conn.ConnectionString = ConfigurationManager _
                 .ConnectionStrings("DefaultConnection").ConnectionString
            Dim cmd As SqlCommand = New SqlCommand
            cmd.CommandText = "[Company_UpdateOrderAddresses]"
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@CompanyID", companyid)
            cmd.Connection = conn
            conn.Open()
            cmd.ExecuteNonQuery()
            b = True
        Catch ex As Exception
            b = False
            Me.ErrorMessageLabel.text = ex.ToString()
        Finally
            conn.Close()
        End Try
        Return b

    End Function

    Private Sub CompanyEditorSqlDataSource_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles CompanyEditorSqlDataSource.Inserting
        Select Case Request.QueryString("type")
            Case "c"
                e.Command.Parameters("@Vendor").Value = False
                e.Command.Parameters("@Customer").Value = True
            Case "v"
                e.Command.Parameters("@Vendor").Value = True
                e.Command.Parameters("@Customer").Value = False
            Case "l"
                e.Command.Parameters("@Vendor").Value = False
                e.Command.Parameters("@Customer").Value = False
        End Select
    End Sub
End Class