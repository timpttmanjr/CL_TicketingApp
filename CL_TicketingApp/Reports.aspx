<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Reports.aspx.vb" Inherits="CL_TicketingApp.Reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <p>
    QuickBooks Export:
</p>
Delivery Date is between
<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;and
<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="ExportButton" runat="server" Text="Export" />

</asp:Content>
