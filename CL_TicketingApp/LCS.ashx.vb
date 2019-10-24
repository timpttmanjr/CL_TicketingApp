Imports System.Web
Imports System.Web.Services

Public Class LCS
    Implements System.Web.IHttpHandler

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        'context.Response.ContentType = "text/plain"
        'context.Response.Write("Hello World!")

        'Dim soid As Integer = Integer.Parse(context.Request.QueryString("SOID"))

        Dim i As Integer = Integer.Parse(context.Request.QueryString("SOID"))

        Dim dt As New ShippingOrderDataSet.LoadConfirmationSheetDataTable
        Using ta As New ShippingOrderDataSetTableAdapters.LoadConfirmationSheetTableAdapter
            ta.Fill(dt, i)
        End Using
        If dt.Rows.Count = 1 Then
            Dim viewer As New Microsoft.Reporting.WebForms.ReportViewer()

            'Create Report Data Source
            Dim rptDataSource As New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt.DefaultView)

            viewer.LocalReport.DataSources.Add(rptDataSource)
            viewer.LocalReport.ReportPath = context.Server.MapPath("~/LoadConfirmationSheetReport.rdlc")

            'Dim fn As String = ""
            'If CType(context.sender, LinkButton).ID = "PrintBOLButton" Then
            '    viewer.LocalReport.ReportPath = context.Server.MapPath("~/BillOfLadingReport.rdlc")
            '    fn = "BillOfLading"
            'Else
            Dim fn As String = "LoadConfirmationSheet"
            viewer.LocalReport.ReportPath = context.Server.MapPath("~/LoadConfirmationSheetReport.rdlc")
            'End If

            'Export to PDF
            Dim pdfContent As Byte() = viewer.LocalReport.Render("PDF", Nothing, Nothing, Nothing, Nothing, Nothing, Nothing)


            'Return PDF
            context.Response.Clear()
            context.Response.ContentType = "application/pdf"
            context.Response.AddHeader("Content-disposition", "attachment; filename=" + fn + ".pdf")
            context.Response.BinaryWrite(pdfContent)
            context.Response.End()

        End If

    End Sub



    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class