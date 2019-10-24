Public Class OrderReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ExportButton_Click(sender As Object, e As EventArgs) Handles ExportButton.Click
        Dim t As New OrderReportDataSet.ShippingOrderDataTable
        Using ta As New OrderReportDataSetTableAdapters.ShippingOrderTableAdapter
            ta.Fill(t, Me.StartDateTextBox.Text, Me.EndDateTextBox.Text)
        End Using
        If t.Rows.Count > 0 Then
            '        Case "XML"

            ''this code will remove guid fields from the dataset
            'Dim i As Int32 = 0
            'While i < t.Columns.Count
            '    If t.Columns(i).DataType.ToString = "System.Guid" Then ' t.Rows(0).Item(i).ToString() Then
            '        t.Columns.RemoveAt(i)
            '        i = i - 1
            '    End If
            '    i = i + 1
            'End While

            Me.Response.Clear()
            'Me.Response.ContentType = "application/octet-stream"
            Me.Response.ContentType = "application/excel"
            Me.Response.AddHeader("Content-disposition", "attachment; filename=OrderReport.xml")
            t.WriteXml(Response.OutputStream, Data.XmlWriteMode.IgnoreSchema)
            Me.Response.End()
        End If

    End Sub
End Class