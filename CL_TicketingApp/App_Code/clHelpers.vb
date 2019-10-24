Imports System.Data
Imports System.Data.SqlClient


Namespace CitationLogistics
    Public Class clHelpers
        Public Sub New()

        End Sub

        Public Shared Function GetCompanyIDFromSQL(CompanyName As String) As Integer
            Dim i As Integer
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
            Try
                Dim cmd As New SqlCommand("[CompanySelectByName]", con)
                With cmd
                    .CommandType = CommandType.StoredProcedure
                    .Parameters.AddWithValue("@CompanyName", CompanyName)
                    .Connection.Open()

                    i = .ExecuteScalar
                End With
            Catch ex As Exception
                i = -1
            Finally
                con.Close()
            End Try
            Return i
        End Function
    End Class
End Namespace
