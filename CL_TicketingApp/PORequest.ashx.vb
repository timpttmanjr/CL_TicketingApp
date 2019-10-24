Imports System.Web
Imports System.Web.Services

Public Class PORequest
    Implements System.Web.IHttpHandler

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        'context.Response.ContentType = "text/plain"
        'context.Response.Write("Hello World!")

        Dim soid As Integer = Integer.Parse(context.Request.QueryString("SOID"))

        MarkPORAsPrinted(soid)


        Dim dt As New PORequestDataSet.PORequestSheetDataTable
        Using ta As New PORequestDataSetTableAdapters.PORequestSheetTableAdapter
            ta.Fill(dt, soid)
        End Using
        If dt.Rows.Count = 1 Then
            Dim viewer As New Microsoft.Reporting.WebForms.ReportViewer()

            'Create Report Data Source
            Dim rptDataSource As New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt.DefaultView)

            viewer.LocalReport.DataSources.Add(rptDataSource)
            Dim fn As String = ""

            viewer.LocalReport.ReportPath = context.Server.MapPath("~/PurchaseOrderRequestReport.rdlc")
            fn = "PurchaseOrderRequest" + Convert.ToString(dt.Rows(0)("OrderNumber"))



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

    Sub MarkPORAsPrinted(soid As Integer)
        Dim con As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Try
            Dim cmd As New SqlClient.SqlCommand
            With cmd
                .Connection = con
                .CommandText = "update shippingorder set PORequested = '" + Now.ToShortDateString + "' where shippingorderid = " + soid.ToString()
                .CommandType = CommandType.Text
                .Connection.Open()
                .ExecuteNonQuery()
            End With
        Catch ex As Exception
            '            Me.CopyMessageLabel.text = ex.ToString
        Finally
            con.Close()
        End Try
    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class