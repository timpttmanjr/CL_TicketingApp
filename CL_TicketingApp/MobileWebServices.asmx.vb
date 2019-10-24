Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel
Imports System.Data.SqlClient

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class MobileWebServices
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function MobileOrders(OrderNumber As String, DriverEmail As String) As MobileWebServicesDataSet
        Dim x As New MobileWebServicesDataSet
        Dim ta As New MobileWebServicesDataSetTableAdapters.ShippingOrder_MobileSearchTableAdapter
        ta.Fill(x.ShippingOrder_MobileSearch, OrderNumber, DriverEmail)
        Return x


    End Function


    <WebMethod()>
    Public Sub MobileUpdate(ShippingOrderID As Integer, a1CompletionDate As Nullable(Of Date), a2CompletionDate As Nullable(Of Date), a3CompletionDate As Nullable(Of Date), a4CompletionDate As Nullable(Of Date))

        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Try
            Dim par1 As New SqlParameter("@a1CompletionDate", a1CompletionDate)
            par1.IsNullable = True
            par1.SqlDbType = SqlDbType.DateTime
            par1.Direction = ParameterDirection.Input
            Dim par2 As New SqlParameter("@a2CompletionDate", a2CompletionDate)
            par2.IsNullable = True
            par2.SqlDbType = SqlDbType.DateTime
            par2.Direction = ParameterDirection.Input
            Dim par3 As New SqlParameter("@a3CompletionDate", a3CompletionDate)
            par3.IsNullable = True
            par3.SqlDbType = SqlDbType.DateTime
            par3.Direction = ParameterDirection.Input
            Dim par4 As New SqlParameter("@a4CompletionDate", a4CompletionDate)
            par4.IsNullable = True
            par4.SqlDbType = SqlDbType.DateTime
            par4.Direction = ParameterDirection.Input

            Using cmd As New SqlCommand
                With cmd
                    .CommandText = "[ShippingOrder_MobileUpdate]"
                    .Parameters.AddWithValue("@ShippingOrderID", ShippingOrderID)
                    .Parameters.Add(par1)
                    .Parameters.Add(par2)
                    .Parameters.Add(par3)
                    .Parameters.Add(par4)
                    .Connection = con
                    .CommandType = Data.CommandType.StoredProcedure
                    .Connection.Open()
                    .ExecuteNonQuery()
                End With
            End Using
        Catch ex As Exception
            'My.Application.Log.WriteException(ex)
            'Elmah.ErrorSignal.FromCurrentContext().Raise(ex)
        Finally
            con.Close()
        End Try


    End Sub

    <WebMethod()>
    Public Sub MobileAssignOrderToDriver(ShippingOrderID As Integer, DriverEmail As String)

        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Try


            Using cmd As New SqlCommand
                With cmd
                    .CommandText = "update shippingorder set driveremail = '" & DriverEmail & "' where shippingorderid = " & ShippingOrderID

                    .Connection = con
                    .CommandType = Data.CommandType.StoredProcedure
                    .Connection.Open()
                    .ExecuteNonQuery()
                End With
            End Using
        Catch ex As Exception
            'My.Application.Log.WriteException(ex)
            'Elmah.ErrorSignal.FromCurrentContext().Raise(ex)
        Finally
            con.Close()
        End Try


    End Sub

    <WebMethod()>
    Public Sub ShippingOrderLocationInsert(ShippingOrdreID As Integer, DriverID As String, LocationTimeStamp As Date, Latitude As Decimal, Longitude As Decimal, Altitude As Decimal, Notes As String)
        Try

            Using ta As New MobileWebServicesDataSetTableAdapters.ShippingOrderLocationTableAdapter()
                ta.Insert(ShippingOrdreID, DriverID, LocationTimeStamp, Latitude, Longitude, Altitude, Notes)
            End Using

        Catch ex As Exception
            'My.Application.Log.WriteException(ex)
            'Elmah.ErrorSignal.FromCurrentContext().Raise(ex)
            'Finally

        End Try
    End Sub


End Class