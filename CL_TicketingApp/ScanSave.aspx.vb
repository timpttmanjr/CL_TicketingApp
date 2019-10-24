Imports System.IO
Imports System.Threading.Tasks
Imports Microsoft.WindowsAzure.Storage
Imports Microsoft.WindowsAzure.Storage.Auth
Imports Microsoft.WindowsAzure.Storage.Blob

Public Class ScanSave
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        SaveDoc()

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

    Public Sub SaveDoc()
        Dim x As String = HttpContext.Current.Session("Scan.ReturnURL")
        Try

            'Dim ImageID As Guid = Session("Scan.ImageID")
            'Dim LinkID As Guid = New Guid(Session("Scan.LinkID").ToString())



            Dim files As HttpFileCollection = HttpContext.Current.Request.Files
            Dim uploadfile As HttpPostedFile = files("RemoteFile")
            If uploadfile IsNot Nothing Then

                'Dim inputLength As Integer = uploadfile.ContentLength - 1
                'Dim inputBuffer As Byte() = New Byte(inputLength) {}
                'Dim inputStream As System.IO.Stream = uploadfile.InputStream
                'inputStream.Read(inputBuffer, 0, inputLength)

                'Dim filename As String = "c:\temp\citation\" + HttpContext.Current.Session("Scan.SOID").ToString() + "_bol.pdf"
                'Using fileStream As IO.FileStream = IO.File.Create(filename)
                '    inputStream.Seek(0, SeekOrigin.Begin)
                '    inputStream.CopyTo(fileStream)

                Dim b As Boolean = UploadFileToStorage(uploadfile.InputStream, HttpContext.Current.Session("Scan.SOID").ToString() + "_bol.pdf")
                '    If b = False Then
                '        Throw New Exception("Save to Azure failed.")
                '    End If
                'End Using







                'Dim sqlConnection As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("eCourt").ConnectionString)
                'Try
                '    Dim SqlCmdText As [String] = "[GetPath]"
                '    Dim sqlCmdObj As New System.Data.SqlClient.SqlCommand(SqlCmdText, sqlConnection)
                '    sqlCmdObj.CommandType = Data.CommandType.StoredProcedure
                '    sqlCmdObj.Parameters.AddWithValue("@FolderName", LinkID.ToString)


                '    sqlConnection.Open()
                '    Dim FolderPath As String = sqlCmdObj.ExecuteScalar()

                '    sqlCmdObj.Parameters.Clear()
                '    sqlCmdObj.CommandType = Data.CommandType.Text

                '    SqlCmdText = "INSERT INTO FINS (stream_id,file_stream, name,path_locator) VALUES (@ImageID,@Image, @ImageName, @path_locator)"
                '    sqlCmdObj = New System.Data.SqlClient.SqlCommand(SqlCmdText, sqlConnection)

                '    sqlCmdObj.Parameters.Add("@Image", System.Data.SqlDbType.Binary, inputBuffer.Length).Value = inputBuffer
                '    sqlCmdObj.Parameters.Add("@ImageID", System.Data.SqlDbType.VarChar, 255).Value = ImageID.ToString()
                '    sqlCmdObj.Parameters.Add("@ImageName", System.Data.SqlDbType.VarChar, 255).Value = ImageID.ToString() + ".pdf"
                '    sqlCmdObj.Parameters.Add("@path_locator", System.Data.SqlDbType.VarChar, 255).Value = FolderPath

                '    sqlCmdObj.ExecuteNonQuery()


                'Catch ex As Exception
                '    Throw New Exception("Error saving document to doc file table", ex)
                'Finally
                '    sqlConnection.Close()
                'End Try

            Else

                Me.ErrorMessageLabel.Text = "No image found in post.  Please contact IT"

            End If


        Catch ex As Exception



            Me.ErrorMessageLabel.Text = ex.ToString
        End Try





    End Sub

End Class