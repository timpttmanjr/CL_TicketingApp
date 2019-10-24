<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="OrderReport.aspx.vb" Inherits="CL_TicketingApp.OrderReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Order Report</h1>
    <br />
    <br />
    Order date is between <asp:TextBox ID="StartDateTextBox" runat="server"></asp:TextBox> and <asp:TextBox ID="EndDateTextBox" runat="server"></asp:TextBox>&nbsp;<asp:Button ID="ExportButton" runat="server" Text="Export to Excel [xml]" />
    <br />
    <br />
        <cc1:CalendarExtender ID="StartDateTextBoxCalendarExtender" PopupButtonID="StartDateTextBox" TargetControlID="StartDateTextBox" runat="server" />
    <cc1:CalendarExtender ID="EndDateTextBoxCalendarExtender" PopupButtonID="EndDateTextBox" TargetControlID="EndDateTextBox" runat="server" />

</asp:Content>
