<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Billing.aspx.vb" Inherits="CL_TicketingApp.Billing" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <%-- <script src="Scripts/DataTables/jquery.dataTables.js"></script>--%>
    <h1>Billing</h1>
    <br />
    Company name is like <asp:TextBox runat="server" ID="CompanyNameTextBox"></asp:TextBox> (Leave blank for all)
    <br />
    and
    <br />
    Final delivery date is between <asp:TextBox ID="StartDateTextBox" runat="server"></asp:TextBox> and <asp:TextBox ID="EndDateTextBox" runat="server"></asp:TextBox>
    &nbsp;<asp:Button ID="SearchButton" runat="server" Text="Search" />
    <br />
    <br />
    <cc1:CalendarExtender ID="StartDateTextBoxCalendarExtender" PopupButtonID="StartDateTextBox" TargetControlID="StartDateTextBox" runat="server" />
    <cc1:CalendarExtender ID="EndDateTextBoxCalendarExtender" PopupButtonID="EndDateTextBox" TargetControlID="EndDateTextBox" runat="server" />
    <p>Select items to be included in Invoice Batch</p>    <br />

    <asp:GridView ID="OrdersGridView" runat="server" AutoGenerateColumns="False" CellPadding="3" ShowFooter="true" DataKeyNames="ShippingOrderID" DataSourceID="ShippingOrdersSqlDataSource" ForeColor="Black" GridLines="Vertical" Width="100%" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" AllowSorting="true">
        <AlternatingRowStyle BackColor="#CCCCCC" />
        <Columns>
            <asp:BoundField DataField="OrderNumber" HeaderText="Order" InsertVisible="False" ReadOnly="True" SortExpression="OrderNumber" />
            <asp:BoundField DataField="StatusType" HeaderText="Status" SortExpression="StatusType" />
            <asp:BoundField DataField="CustomerName" HeaderText="Customer" SortExpression="CustomerName" />
            <asp:BoundField DataField="Pickup" HeaderText="Pickup" ReadOnly="True" SortExpression="Pickup"  />
            <asp:BoundField DataField="Delivery" HeaderText="Delivery" ReadOnly="True" SortExpression="Delivery" />
            <asp:BoundField DataField="CarrierName" HeaderText="Carrier" SortExpression="CarrierName" />
            <asp:BoundField DataField="CarrierContact" HeaderText="Contact" SortExpression="CarrierContact" />
            <asp:BoundField DataField="CarrierPhone" HeaderText="Phone" SortExpression="CarrierPhone" />
            <asp:BoundField DataField="CarrierDriverName" HeaderText="Driver" SortExpression="CarrierDriverName" />
            <asp:BoundField DataField="CarrierDriverCell" HeaderText="Cell" SortExpression="CarrierDriverCell" />
            <asp:BoundField DataField="CommodityType" HeaderText="Commodity" SortExpression="CommodityType" />
            <asp:BoundField DataField="LoadType" HeaderText="Load" SortExpression="LoadType" />
            <asp:BoundField DataField="Tarp" HeaderText="Tarp" SortExpression="Tarp" />
            <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight" />
            <asp:TemplateField HeaderText="Charge" SortExpression="CustomerBillAmount">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("CustomerBillAmount") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("CustomerBillAmount", "{0:c}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Extra Charge" SortExpression="ExtraCharge1Amount">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ExtraCharge1Amount") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="ExtraCharge1AmountLabel" runat="server" Text='<%# Bind("ExtraCharge1Amount", "{0:c}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Pay" SortExpression="CarrierPayAmount">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CarrierPayAmount") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CarrierPayAmount", "{0:c}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Extra Pay" SortExpression="ExtraPay1Amount">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ExtraPay1Amount") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="ExtraPay1AmountLabel" runat="server" Text='<%# Bind("ExtraPay1Amount", "{0:c}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Net" SortExpression="Net">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Net") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="NetTotalLabel" runat="server" Text="0"></asp:Label>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="NetLabel" runat="server" Text='<%# Bind("Net", "{0:c}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="PO" HeaderText="PO" SortExpression="PO" />
            <asp:BoundField DataField="BOL" HeaderText="BOL" SortExpression="BOL" />
            <asp:TemplateField>
                <ItemTemplate><asp:CheckBox runat="server" ID="BillCheckBox" Checked="false" /></ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#CCCCCC" />
        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
        <EmptyDataTemplate>There are no "Completed" orders matching the selected criteria.</EmptyDataTemplate>
    </asp:GridView>
    
    <asp:SqlDataSource ID="ShippingOrdersSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT  ShippingOrder.ShippingOrderID ,
        ShippingOrder.CustomerCompanyID ,
        ShippingOrder.CarrierCompanyID ,
        ShippingOrder.CarrierContact ,
        ShippingOrder.CarrierPhone ,
        ShippingOrder.CarrierFax ,
        ShippingOrder.CarrierEmail ,
        ShippingOrder.Notes ,
        ShippingOrder.CustomerPONumber ,
        ShippingOrder.CustomerBillAmount ,
        ShippingOrder.CarrierPayAmount ,
        ( ISNULL(ShippingOrder.CustomerBillAmount, 0) - isnull(shippingorder.extrapay1amount,0)
          - ISNULL(ShippingOrder.CarrierPayAmount, 0) + isnull(shippingorder.extracharge1amount,0) ) AS Net ,
        ShippingOrder.CarrierDriverName ,
        ShippingOrder.CarrierDriverCell ,
        ShippingOrder.CommodityType ,
        ShippingOrder.LoadType ,
        ShippingOrder.Tarp ,
        ShippingOrder.Weight ,
        ShippingOrder.StatusType ,
        Customer.CompanyName AS CustomerName ,
        Carrier.CompanyName AS CarrierName ,
        '' AS Pickup ,
        '' AS Delivery, OrderNumber, ExtraPay1Amount, ExtraCharge1Amount, PO, BOL
FROM    Company AS Customer
        INNER JOIN ShippingOrder ON Customer.Id = ShippingOrder.CustomerCompanyID
        LEFT OUTER JOIN Company AS Carrier ON ShippingOrder.CarrierCompanyID = Carrier.Id
WHERE Customer.CompanyName like @CompanyName and ShippingOrder.StatusType not in ('Billed','Cancelled') and
ShippingOrder.OrderDate BETWEEN @StartDate AND @EndDate order by OrderNumber">
        <SelectParameters>
            <asp:ControlParameter ControlID="StartDateTextBox" Name="StartDate" PropertyName="Text" />
            <asp:ControlParameter ControlID="EndDateTextBox" Name="EndDate" PropertyName="Text" />
            <asp:ControlParameter ControlID="CompanyNameTextBox" Name="CompanyName" PropertyName="Text" />

        </SelectParameters>
</asp:SqlDataSource>
    <br />    <br />

    <asp:Button ID="ExportToQuickBooksButton" runat="server" Text="Create Invoice Batch" Enabled="False" />
    
    <br />
    <br />
    <br />
    <br />
    Choose a batch to export in QuickBooks iif format:
    <asp:DropDownList ID="InvoiceBatchDropDownList" AutoPostBack="true" runat="server" DataSourceID="InvoiceBatchHistorySqlDataSource" DataTextField="InvoiceDate" DataValueField="InvoiceBatch">
    </asp:DropDownList>
    <asp:SqlDataSource ID="InvoiceBatchHistorySqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="select distinct InvoiceBatch, so.InvoiceDate as InvoiceDateForOrder, cast( InvoiceDate as varchar(50)) + CASE (SELECT COUNT(*) FROM ((SELECT DISTINCT CustomerCompanyID FROM dbo.ShippingOrder AS xso WHERE xso.ShippingOrderID = so.ShippingOrderID AND xso.CustomerCompanyID = 1394)) xx) WHEN 1 THEN ' Sunbelt' ELSE '' END AS InvoiceDate from shippingOrder so where invoicedate > (GETDATE() - 365) order by InvoiceDateForOrder desc"></asp:SqlDataSource>
    <asp:Button ID="ExportBatchButton" runat="server" Text="Export Quickbooks File" />
     <asp:Button ID="ExportSunbeltBatchButton" runat="server" Text="Export Sunbelt File" />
    <br />
    <br />
    <asp:GridView ID="InvoiceBatchGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="ShippingOrderID" DataSourceID="InvoiceBatchReportSqlDataSource" ShowFooter="True" Width="100%">
        <Columns>
            <asp:BoundField DataField="OrderNumber" HeaderText="Order" SortExpression="OrderNumber" />
            <asp:BoundField DataField="OrderDate" DataFormatString="{0:d}" HeaderText="Order Date" SortExpression="OrderDate" />
<asp:BoundField DataField="CustomerCompanyName" HeaderText="Customer" SortExpression="CustomerCompanyName" />
<asp:BoundField DataField="PO" HeaderText="PO" SortExpression="PO" />
<asp:BoundField DataField="BOL" HeaderText="BOL" SortExpression="BOL" />


 <asp:TemplateField HeaderText="Charge" SortExpression="CustomerBillAmount">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("CustomerBillAmount") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("CustomerBillAmount", "{0:c}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Pay" SortExpression="CarrierPayAmount">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CarrierPayAmount") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CarrierPayAmount", "{0:c}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Net" SortExpression="CarrierPayAmount">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Net") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="NetTotalLabel" runat="server" Text="0"></asp:Label>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="NetLabel" runat="server" Text='<%# Bind("Net", "{0:c}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
        <FooterStyle BackColor="#CCCCCC" />
        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
        <EmptyDataTemplate>Please choose an invoice batch.</EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="InvoiceBatchReportSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="InvoiceBatch" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="InvoiceBatchDropDownList" Name="InvoiceBatch" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
  <%--  <script>
$(document).ready( function () {
    $('#MainContent_OrdersGridView').DataTable();
} );
    </script>--%>
</asp:Content>
