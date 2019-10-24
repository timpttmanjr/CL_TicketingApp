


Public Class Orders
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
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

    Protected Sub NewOrderButton_Click(sender As Object, e As EventArgs) Handles NewOrderButton.Click, NewOrderButton1.Click
        Response.Redirect("~/NewOrder.aspx")
    End Sub


    Protected Sub EditButton_Click(sender As Object, e As EventArgs)
        Dim i As Integer = CType(sender, Button).CommandArgument
        Response.Redirect("~/NewOrder.aspx?soid=" & i.ToString)
    End Sub

    Protected Sub PrintButton_Click(sender As Object, e As EventArgs)

        Dim i As Integer = CType(sender, Button).CommandArgument

        Dim dt As New ShippingOrderDataSet.LoadConfirmationSheetDataTable
        Using ta As New ShippingOrderDataSetTableAdapters.LoadConfirmationSheetTableAdapter
            ta.Fill(dt, i)
        End Using
        If dt.Rows.Count = 1 Then
            Dim viewer As New Microsoft.Reporting.WebForms.ReportViewer()

            'Create Report Data Source
            Dim rptDataSource As New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt.DefaultView)

            viewer.LocalReport.DataSources.Add(rptDataSource)
            viewer.LocalReport.ReportPath = Server.MapPath("~/LoadConfirmationSheetReport.rdlc")

            Dim fn As String = ""
            If CType(sender, Button).ID = "PrintBOLButton" Then
                viewer.LocalReport.ReportPath = Server.MapPath("~/BillOfLadingReport.rdlc")
                fn = "BillOfLading"
            Else
                fn = "LoadConfirmationSheet"
                viewer.LocalReport.ReportPath = Server.MapPath("~/LoadConfirmationSheetReport.rdlc")
            End If

            'Export to PDF
            Dim pdfContent As Byte() = viewer.LocalReport.Render("PDF", Nothing, Nothing, Nothing, Nothing, Nothing, Nothing)


            'Return PDF
            Me.Response.Clear()
            Me.Response.ContentType = "application/pdf"
            Me.Response.AddHeader("Content-disposition", "attachment; filename=" + fn + ".pdf")
            Me.Response.BinaryWrite(pdfContent)
            Me.Response.End()

        End If
    End Sub




    Protected Sub DuplicateButton_Click(sender As Object, e As EventArgs)
        Dim i As Integer = CType(sender, Button).CommandArgument


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

    Private Sub OrderStatusSqlDataSource_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles OrderStatusSqlDataSource.Selecting
        Me.Session("Orders.StartDate") = Me.StartDateTextBox.Text
        Me.Session("Orders.EndDate") = Me.EndDateTextBox.Text
        Me.Session("Orders.OrderStatus.SelectedIndex") = Me.OrderStatusDropDownList.SelectedIndex
        Me.Session("Orders.OrderNumber") = Me.OrderNumberTextBox.Text
    End Sub

    Private Sub OrderStatusDropDownList_DataBound(sender As Object, e As EventArgs) Handles OrderStatusDropDownList.DataBound
        Try
            OrderStatusDropDownList.ClearSelection()
            OrderStatusDropDownList.Items.FindByValue("Assigned").Selected = True
        Catch ex As Exception

        End Try
    End Sub

    Private Sub OrdersGridView_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles OrdersGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            'If User.IsInRole("Accounting") Then
            '    CType(e.Row.FindControl("InvoiceLink"), HtmlGenericControl).Visible = False
            'Else
            '    CType(e.Row.FindControl("InvoiceLink"), HtmlGenericControl).Visible = False

            'End If
            'If User.IsInRole("Imaging") Then
            If CType(e.Row.FindControl("BackupDocPathHiddenField"), HiddenField).Value = "" Then
                CType(e.Row.FindControl("EnabledViewButton"), Button).Visible = False
                'CType(e.Item.FindControl("DisabledViewButton"), HtmlControl).Visible = True
            Else
                CType(e.Row.FindControl("EnabledViewButton"), Button).Visible = True
                'CType(e.Item.FindControl("DisabledViewButton"), HtmlControl).Visible = False
            End If

            'End If
        End If
    End Sub

    Protected Sub ScanDocButton_Click(sender As Object, e As EventArgs)
        Session("InvoicePrep.StartDate") = Me.StartDateTextBox.Text
        Session("InvoicePrep.EndDate") = Me.EndDateTextBox.Text

        Response.Redirect("~/BOLScanner.aspx?soid=" + CType(sender, Button).CommandArgument)
    End Sub
End Class