<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="OnTimeReport.aspx.vb" Inherits="CL_TicketingApp.OnTimeReport" MasterPageFile="~/Site.Master"  %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Order Report</h1>
    <br />
    <br />
    Customer is <asp:DropDownList ID="CustomerDropDownList" runat="server" DataSourceID="SqlDataSource1" DataTextField="CompanyName" DataValueField="Id"></asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Id], [CompanyName] FROM [Company] WHERE ([Customer] = @Customer) ORDER BY [CompanyName]">
        <SelectParameters>
            <asp:Parameter DefaultValue="true" Name="Customer" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    Order date is between <asp:TextBox ID="StartDateTextBox" runat="server"></asp:TextBox> and <asp:TextBox ID="EndDateTextBox" runat="server"></asp:TextBox>&nbsp;<asp:Button ID="ExportButton" runat="server" Text="Export to Excel [xml]" />
    <br />
    <br />
        <cc1:CalendarExtender ID="StartDateTextBoxCalendarExtender" PopupButtonID="StartDateTextBox" TargetControlID="StartDateTextBox" runat="server" />
    <cc1:CalendarExtender ID="EndDateTextBoxCalendarExtender" PopupButtonID="EndDateTextBox" TargetControlID="EndDateTextBox" runat="server" />

</asp:Content>
