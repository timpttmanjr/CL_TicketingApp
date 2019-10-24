<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="test.aspx.vb" Inherits="CL_TicketingApp.test" MasterPageFile="~/Site.Master" %>

<%@ Register Src="~/CompanyPopupWrapperWebUserControl.ascx" TagPrefix="uc1" TagName="CompanyPopupWrapperWebUserControl" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>


<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="MainContent">
    
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"></asp:ObjectDataSource>
    
    <uc1:CompanyPopupWrapperWebUserControl runat="server" id="CompanyPopupWrapperWebUserControl" />

    <asp:TextBox ID="TextBox1" runat="server" class="hasDatepicker"></asp:TextBox>

</asp:Content>

