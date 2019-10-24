<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NewOrderComplete.aspx.vb" Inherits="CL_TicketingApp.NewOrderComplete" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" runat="server" contentplaceholderid="MainContent">
    <h1>Order Saved</h1
    <p></p>
    <p>
    </p>
    <asp:Button ID="PrintButton" runat="server" Text="Print Load Confirmation Sheet" Enabled="true" />&nbsp;
    <asp:Button ID="PrintBOLButton" runat="server" Text="Print Bill of Lading" Enabled="true" />&nbsp;
    <br />
    <br />
    Add <asp:TextBox ID="CopiesTextBox" runat="server" Width="25px"></asp:TextBox>
&nbsp;pending copies of this order.
    <asp:Button ID="CopyButton" runat="server" Enabled="true" Text="Add" />
    <br />
    <asp:Label ID="CopyMessageLabel" runat="server" ForeColor="Red" text=""></asp:Label>
</asp:Content>


