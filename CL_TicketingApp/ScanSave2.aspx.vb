Imports System.IO
Imports System.Threading.Tasks
Imports Microsoft.WindowsAzure.Storage
Imports Microsoft.WindowsAzure.Storage.Auth
Imports Microsoft.WindowsAzure.Storage.Blob

Public Class ScanSave2
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SaveDoc()
    End Sub

    Public Sub SaveDoc()
        Dim x As String = HttpContext.Current.Session("Scan.ReturnURL")
        Try
            Dim files As HttpFileCollection = HttpContext.Current.Request.Files
            Dim uploadfile As HttpPostedFile = files("RemoteFile")
            If uploadfile IsNot Nothing Then
                Dim b As Boolean = UploadFileToStorage(uploadfile.InputStream, HttpContext.Current.Session("Scan.ID").ToString() + "_co.pdf")
            Else
                Me.ErrorMessageLabel.Text = "No image found in post.  Please contact IT"
            End If
        Catch ex As Exception
            Me.ErrorMessageLabel.Text = ex.ToString
        End Try
    End Sub

    Public Function UploadFileToStorage(ByVal fileStream As Stream, ByVal fileName As String) As Boolean
        Dim b As Boolean = False
        Try
            Dim _accountName As String = "citationlogistics"
            Dim _accountKey As String = "ID/uQ/pVgn47TAozl/lfOVSbrQp9zkSDOlQR8oxOW71Te1Skzwo71jJBe1qExi7Nas5S98rAzSVWb0l9cBkQfQ=="
            Dim _accountConnectionString As String = "DefaultEndpointsProtocol=https;AccountName=citationlogistics;AccountKey=ID/uQ/pVgn47TAozl/lfOVSbrQp9zkSDOlQR8oxOW71Te1Skzwo71jJBe1qExi7Nas5S98rAzSVWb0l9cBkQfQ==;EndpointSuffix=core.windows.net"
            Dim _accountImageContainer As String = "images"

            Dim storageCredentials As StorageCredentials = New StorageCredentials(_accountName, _accountKey)
            Dim storageAccount As CloudStorageAccount = New CloudStorageAccount(storageCredentials, True)
            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference(_accountImageContainer)
            Dim blockBlob As CloudBlockBlob = container.GetBlockBlobReference(fileName)

            Using fileStream
                fileStream.Position = 0
                blockBlob.UploadFromStream(fileStream)
            End Using
            b = True
        Catch ex As Exception
            b = False
            'todo: add error handling
        End Try
        Return b
    End Function
End Class