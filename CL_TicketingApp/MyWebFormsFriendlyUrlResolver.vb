
''' <summary>
''' HACK: Disable ".Mobile.Master" master pages.
''' </summary>
Public Class MyWebFormsFriendlyUrlResolver
    Inherits Microsoft.AspNet.FriendlyUrls.Resolvers.WebFormsFriendlyUrlResolver

    ''' <summary>
    ''' Disable ".Mobile.Master" master pages.
    ''' </summary>
    Protected Overrides Function TrySetMobileMasterPage(httpContext As HttpContextBase, page As UI.Page, mobileSuffix As String) As Boolean
        If mobileSuffix = "Mobile" Then
            Return False
        Else
            Return MyBase.TrySetMobileMasterPage(httpContext, page, mobileSuffix)
        End If
    End Function
End Class