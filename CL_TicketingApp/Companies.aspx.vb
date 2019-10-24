Imports System.Data.SqlClient

Public Class Companies
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("cl.user") <> True Then Response.Redirect("~/Account/Login.aspx")
    End Sub

    Protected Sub NewButton_Click(sender As Object, e As EventArgs) Handles NewCustomerButton.Click
        Response.Redirect("~/CompanyEditor.aspx?type=c")
    End Sub

    Protected Sub NewVendorButton_Click(sender As Object, e As EventArgs) Handles NewVendorButton.Click
        Response.Redirect("~/CompanyEditor.aspx?type=v")
    End Sub

    Protected Sub NewLocationButton_Click(sender As Object, e As EventArgs) Handles NewLocationButton.Click
        Response.Redirect("~/CompanyEditor.aspx?type=l")
    End Sub

    Protected Sub SearchButton_Click(sender As Object, e As EventArgs) Handles SearchButton.Click
        Me.GridView1.DataBind()
    End Sub

    Private Sub CompanyDataSource_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles CompanyDataSource.Selecting
        Select Case Me.CompanyTypeDropDownList.SelectedValue
            Case "Customers"
                e.Command.Parameters("@Vendor").Value = 0
                e.Command.Parameters("@Customer").Value = 1
                Me.GridView1.Columns(6).Visible = False 'shipping
                Me.GridView1.Columns(7).Visible = True 'billing
                Me.GridView1.Columns(8).Visible = False 'mc number
            Case "Vendors"
                e.Command.Parameters("@Vendor").Value = 1
                e.Command.Parameters("@Customer").Value = 0
                Me.GridView1.Columns(6).Visible = False 'shipping
                Me.GridView1.Columns(7).Visible = True 'billing
                Me.GridView1.Columns(8).Visible = True 'mc number
            Case Else
                e.Command.Parameters("@Vendor").Value = 0
                e.Command.Parameters("@Customer").Value = 0
                Me.GridView1.Columns(6).Visible = True 'shipping
                Me.GridView1.Columns(7).Visible = False 'billing
                Me.GridView1.Columns(8).Visible = False 'mc number
        End Select
        e.Command.Parameters("@Filter").Value = "%" + Me.TextBox1.Text + "%"

    End Sub

    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "GoToEditor" Then Response.Redirect("~/CompanyEditor.aspx?coid=" & e.CommandArgument())
    End Sub

    Private Sub PurgeButton_Click(sender As Object, e As EventArgs) Handles PurgeButton.Click
        Dim conn As SqlConnection = New SqlConnection
        conn.ConnectionString = ConfigurationManager _
             .ConnectionStrings("DefaultConnection").ConnectionString

        Try
            Dim cmd As SqlCommand = New SqlCommand
            cmd.CommandText = "[DisableOldLocations]"
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = conn
            conn.Open()
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
    End Sub

    Protected Sub ScanDocButton_Click(sender As Object, e As EventArgs)
        'Session("InvoicePrep.StartDate") = Me.StartDateTextBox.Text
        'Session("InvoicePrep.EndDate") = Me.EndDateTextBox.Text

        Response.Redirect("~/BOLScanner2.aspx?id=" + CType(sender, Button).CommandArgument)
    End Sub
End Class