Imports System.IO
Imports System.Web
Imports System.Web.Services
Imports Microsoft.WindowsAzure.Storage
Imports Microsoft.WindowsAzure.Storage.Auth
Imports Microsoft.WindowsAzure.Storage.Blob

Public Class ImageViewer
    Implements System.Web.IHttpHandler

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest



        Dim fileName As String = context.Request.QueryString("SOID").ToString() + "_bol.pdf"

            Dim _accountName As String = "citationlogistics"
            Dim _accountKey As String = "ID/uQ/pVgn47TAozl/lfOVSbrQp9zkSDOlQR8oxOW71Te1Skzwo71jJBe1qExi7Nas5S98rAzSVWb0l9cBkQfQ=="
            Dim _accountConnectionString As String = "DefaultEndpointsProtocol=https;AccountName=citationlogistics;AccountKey=ID/uQ/pVgn47TAozl/lfOVSbrQp9zkSDOlQR8oxOW71Te1Skzwo71jJBe1qExi7Nas5S98rAzSVWb0l9cBkQfQ==;EndpointSuffix=core.windows.net"
            Dim _accountImageContainer As String = "images"

            Dim storageCredentials As StorageCredentials = New StorageCredentials(_accountName, _accountKey)
            Dim storageAccount As CloudStorageAccount = New CloudStorageAccount(storageCredentials, True)
            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference(_accountImageContainer)



            Dim imageBytes As Byte()

            Dim blob As CloudBlockBlob = container.GetBlockBlobReference(fileName)
            Using MemoryStream = New MemoryStream()
                blob.DownloadToStream(MemoryStream)
                imageBytes = MemoryStream.ToArray()

            End Using








            'Return PDF
            context.Response.Clear()
        context.Response.ContentType = "application/pdf"
        context.Response.AddHeader("Content-disposition", "attachment; filename=" + fileName)
        context.Response.BinaryWrite(imageBytes)
        context.Response.End()


    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property





    'Public Sub FileFromBlob(ByVal fileName As String)
    '    Dim b As Boolean = False

    'End Sub

End Class