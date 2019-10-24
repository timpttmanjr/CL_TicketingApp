Imports Microsoft

Public Class NewOrderComplete
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub PrintButton_Click(sender As Object, e As EventArgs) Handles PrintButton.Click, PrintBOLButton.Click
        Dim dt As New ShippingOrderDataSet.LoadConfirmationSheetDataTable
        Using ta As New ShippingOrderDataSetTableAdapters.LoadConfirmationSheetTableAdapter
            ta.Fill(dt, Request.QueryString("SOID"))
        End Using
        If dt.Rows.Count = 1 Then
            Dim viewer As New Microsoft.Reporting.WebForms.ReportViewer()

            'Create Report Data Source
            Dim rptDataSource As New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt.DefaultView)

            viewer.LocalReport.DataSources.Add(rptDataSource)

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

    Protected Sub CopyButton_Click(sender As Object, e As EventArgs) Handles CopyButton.Click
        If Val(Me.CopiesTextBox.Text) > 0 Then
            Dim con As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
            Try
                Dim cmd As New SqlClient.SqlCommand
                With cmd
                    .Connection = con
                    .CommandText = "[CopyShippingOrder]"
                    .CommandType = CommandType.StoredProcedure
                    .Connection.Open()
                    .Parameters.AddWithValue("@ShippingOrderID", Integer.Parse(Request.QueryString("soid")))
                    .Parameters.AddWithValue("@Copies", Me.CopiesTextBox.Text)
                    .ExecuteNonQuery()
                End With
                Me.CopyMessageLabel.text = "Copy Complete"
            Catch ex As Exception
                Me.CopyMessageLabel.text = ex.ToString
            Finally
                con.Close()
            End Try

        End If

    End Sub
End Class