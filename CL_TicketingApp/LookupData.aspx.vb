Public Class LookupData
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub



    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "Insert" AndAlso Page.IsValid Then
            Me.LookupSqlDataSource.Insert()
        End If
    End Sub

    Private Sub LookupSqlDataSource_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles LookupSqlDataSource.Inserting
        e.Command.Parameters("@Category").Value = CType(Me.GridView1.FooterRow.FindControl("AddCategoryDropDownList"), DropDownList).SelectedValue
        e.Command.Parameters("@Value").Value = CType(Me.GridView1.FooterRow.FindControl("ValueTextBox"), TextBox).Text
        e.Command.Parameters("@DisplayOrder").Value = CType(Me.GridView1.FooterRow.FindControl("DisplayOrderTextBox"), TextBox).Text

    End Sub
End Class