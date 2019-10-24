Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports Microsoft.WindowsAzure.Storage
Imports Microsoft.WindowsAzure.Storage.Auth
Imports Microsoft.WindowsAzure.Storage.Blob

Public Class BOLScanner2
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Request.UrlReferrer Is Nothing Then
                Session("Scan.ReturnURL") = ""
            Else
                Session("Scan.ReturnURL") = Request.UrlReferrer.ToString
            End If

            Session("Scan.ID") = Request.QueryString("id")
        End If
    End Sub

    Public Sub CancelButton_OnClick(sender As Object, e As EventArgs)
        Dim x As String = Session("Scan.ReturnURL")

        Session("Scan.ReturnURL") = ""
        Response.Redirect(x)
    End Sub

    Public Sub btnUpload_OnClick(sender As Object, e As EventArgs)
        Dim x As String = Session("Scan.ReturnURL")

        If SaveDocument(Session("Scan.ID")) Then

            Response.Redirect(x)
        Else
            Throw New System.Exception("cannot confirm that document was saved. please contact IT")
        End If
    End Sub

    Protected Sub btnDelete_OnClick(sender As Object, e As EventArgs) Handles btnDelete.Click
        Dim x As String = Session("Scan.ReturnURL")

        If DeleteDocument(Session("Scan.ID")) Then

            Response.Redirect(x)
        Else
            Throw New System.Exception("cannot confirm that document was deleted. please contact IT")
        End If
    End Sub

    Public Function DeleteDocument(id As Integer) As Boolean
        Dim b As Boolean = False

        Dim con As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ToString)
        Try
            Dim _accountName As String = "citationlogistics"
            Dim _accountKey As String = "ID/uQ/pVgn47TAozl/lfOVSbrQp9zkSDOlQR8oxOW71Te1Skzwo71jJBe1qExi7Nas5S98rAzSVWb0l9cBkQfQ=="
            Dim _accountImageContainer As String = "images"
            Dim storageCredentials As StorageCredentials = New StorageCredentials(_accountName, _accountKey)
            Dim storageAccount As CloudStorageAccount = New CloudStorageAccount(storageCredentials, True)
            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference(_accountImageContainer)
            Dim blockBlob As CloudBlockBlob = container.GetBlockBlobReference(id.ToString() + "_co.pdf")
            blockBlob.Delete()

            Using cmd As New SqlCommand("[CompanyQueue_RemoveBackupDocPathForID]", con)
                With cmd
                    .CommandType = Data.CommandType.StoredProcedure
                    .Parameters.AddWithValue("@ID", id)
                    .Connection.Open()
                    Dim dr As SqlDataReader = .ExecuteReader
                    If dr.HasRows() Then
                        b = True
                    Else
                        b = False
                        Throw New Exception("Document path was not removed.")
                    End If
                End With
            End Using
        Catch ex As Exception
            b = False
            Throw New Exception("Error removing document path from company table.", ex)
        Finally
            con.Close()
        End Try
        Return b
    End Function

    Private Function SaveDocument(id As Integer) As Boolean
        Dim b As Boolean = False
        Dim con As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ToString)
        Dim newFileName As String = id.ToString + "_co.pdf"
        Try
            Using cmd As New SqlCommand("[CompanyQueue_ScanBOLUpdate]", con)
                With cmd
                    .CommandType = Data.CommandType.StoredProcedure
                    .Parameters.AddWithValue("@ID", id)
                    .Parameters.AddWithValue("@Filename", newFileName)
                    .Connection.Open()
                    Dim dr As SqlDataReader = .ExecuteReader
                    If dr.HasRows() Then
                        b = True
                    Else
                        Throw New Exception("Doc record was not inserted.")
                    End If
                End With
            End Using

        Catch ex As Exception

            Throw New Exception("Error saving document to doc table", ex)
        Finally
            con.Close()
        End Try

        Return b
    End Function
End Class