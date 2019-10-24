Public Class OnTimeReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Protected Sub ExportButton_Click(sender As Object, e As EventArgs) Handles ExportButton.Click
        Dim t As New OrderReportDataSet.OnTimeReportDataTable
        Dim cid As Nullable(Of Integer) = Nothing
        If Me.CustomerDropDownList.SelectedIndex > 0 Then
            cid = Me.CustomerDropDownList.SelectedValue
        End If
        Dim sd As Nullable(Of Date) = Nothing
        If IsDate(Me.StartDateTextBox.Text) Then
            sd = Date.Parse(Me.StartDateTextBox.Text)
        End If

        Dim ed As Nullable(Of Date) = Nothing
        If IsDate(Me.EndDateTextBox.Text) Then
            ed = Date.Parse(Me.EndDateTextBox.Text)
        End If
        Using ta As New OrderReportDataSetTableAdapters.OnTimeReportTableAdapter
            ta.Fill(t, cid, sd, ed)
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
            Me.Response.ContentType = "application/octet-stream"
            Me.Response.AddHeader("Content-disposition", "attachment; filename=OnTimeReport" + Now.Ticks.ToString() + ".xml")
            t.WriteXml(Response.OutputStream, Data.XmlWriteMode.IgnoreSchema)
            Me.Response.End()
        End If

    End Sub

End Class