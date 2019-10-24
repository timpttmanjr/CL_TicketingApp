<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Orders.aspx.vb" Inherits="CL_TicketingApp.Orders" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Orders</h1>
        <br />
    <table>
        <tr>
            <td>Order Status:</td>
            <td><asp:DropDownList ID="OrderStatusDropDownList" runat="server" DataSourceID="OrderStatusSqlDataSource" DataTextField="Value" DataValueField="Value" AutoPostBack="False"></asp:DropDownList>
    &nbsp; and Date is between <asp:TextBox ID="StartDateTextBox" runat="server" Width="85px"></asp:TextBox>&nbsp;and&nbsp<asp:TextBox ID="EndDateTextBox" runat="server" Width="85px"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Or order number is:</td>
            <td><asp:TextBox ID="OrderNumberTextBox" runat="server" Width="85px"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Or Carrier is:</td>
            <td><asp:DropDownList ID="CarrierDropDownList" runat="server" AppendDataBoundItems="True" DataSourceID="CarriersSqlDataSource" DataTextField="CompanyName" DataValueField="Id">
        <asp:ListItem Selected="True" Value="">Any Carrier</asp:ListItem>
    </asp:DropDownList></td>
        </tr>
        <tr>
            <td></td>
            <td><asp:Button ID="SearchButton" runat="server" Text="Search" /><asp:Button runat="server" ID="NewOrderButton1" Text="New Order" /></td>
        </tr>
    </table>

    
    <asp:SqlDataSource ID="CarriersSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT Company.Id, Company.CompanyName FROM Company WITH (nolock) INNER JOIN ShippingOrder WITH (nolock) ON Company.Id = ShippingOrder.CarrierCompanyID ORDER BY Company.CompanyName"></asp:SqlDataSource>


    <asp:SqlDataSource ID="OrderStatusSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="Select Value from l where Category = 'Order Status'"></asp:SqlDataSource><cc1:CalendarExtender ID="StartDateTextBoxCalendarExtender" PopupButtonID="StartDateTextBox" TargetControlID="StartDateTextBox" runat="server" />
    <cc1:CalendarExtender ID="EndDateTextBoxCalendarExtender" PopupButtonID="EndDateTextBox" TargetControlID="EndDateTextBox" runat="server" />
    <br />
    <br />
   
    <asp:GridView ID="OrdersGridView" runat="server" AutoGenerateColumns="False"  DataKeyNames="ShippingOrderID" DataSourceID="ShippingOrdersSqlDataSource"  Width="100%" AllowSorting="True" CssClass="table table-hover table-striped table-condensed">
        <HeaderStyle CssClass="table-dark" />
        <AlternatingRowStyle CssClass=""/>
        <Columns>

            <asp:TemplateField SortExpression="OrderNumber"><ItemTemplate>
                <asp:label runat="server" id="OrderNumber" text='<%# Eval("OrderNumber")%>'></asp:label><br/>
                <asp:label runat="server" id="StatusTypeLabel" text='<%# Eval("StatusType")%>'></asp:label><br/>
                <asp:label runat="server" id="OrderDateLabel" text='<%# if(Eval("OrderDate") Is Dbnull.Value,"", string.format(Eval("OrderDate"),"{0:d}")) %>' ></asp:label><br/>
              
            <asp:label CssClass="badge badge-danger" runat="server" id="HighPriortyBadgeLabel" text="High Priority" Visible='<%#If(Eval("Priority") = "1", True, False) %>'></asp:label>
              
            
        </ItemTemplate></asp:TemplateField>
           <%-- <asp:BoundField DataField="OrderNumber" HeaderText="Order" InsertVisible="False" ReadOnly="True" SortExpression="OrderNumber" />
            <asp:BoundField DataField="StatusType" HeaderText="Status" SortExpression="StatusType" />--%>
            <asp:BoundField DataField="CustomerName" HeaderText="Customer" SortExpression="CustomerName" />
            <asp:BoundField DataField="CarrierName" HeaderText="Carrier" SortExpression="CarrierName" />
            <asp:BoundField DataField="CustomerBillAmount" HeaderText="Charge" SortExpression="CustomerBillAmount" DataFormatString="{0:c}" />
            <asp:BoundField DataField="CarrierPayAmount" HeaderText="Pay" SortExpression="CarrierPayAmount" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="CarrierPhone" HeaderText="Phone" SortExpression="CarrierPhone" />
            <asp:BoundField DataField="CarrierDriverCell" HeaderText="Cell" SortExpression="CarrierDriverCell" />
            <asp:BoundField DataField="CommodityType" HeaderText="Commodity" SortExpression="CommodityType" />
            <asp:BoundField DataField="LoadType" HeaderText="Load" SortExpression="LoadType" />
            <asp:BoundField DataField="PORequested" HeaderText="PO" SortExpression="PORequested" />
<%--            <asp:BoundField DataField="Location1CompanyName" HeaderText="Pick" />
            <asp:BoundField DataField="Location2CompanyName" HeaderText="Drop" />--%>


        <asp:TemplateField SortExpression="" HeaderText="Stops"><ItemTemplate>

                <asp:label runat="server" id="a1ActivityTypeLabel" text='<%# Left(Eval("a1ActivityType"),1) + ":&nbsp;" %>' visible='<%# Eval("a1ActivityType").Length > 1 %>'></asp:label><asp:label runat="server" id="Location1CompanyNameLabel" text='<%# Eval("Location1CompanyName")%>'></asp:label>
                          
                <asp:label runat="server" id="a2ActivityTypeLabel" text='<%# "<br />" + Left(Eval("a2ActivityType"),1) + ":&nbsp;" %>' visible='<%# Eval("a2ActivityType").Length > 1 %>'></asp:label><asp:label runat="server" id="Location2CompanyNameLabel" text='<%# Eval("Location2CompanyName")%>'></asp:label>
                <asp:label runat="server" id="a3ActivityTypeLabel" text='<%# "<br />" + Left(Eval("a3ActivityType"),1) + ":&nbsp;" %>' visible='<%# Eval("a3ActivityType").Length > 1 %>'></asp:label><asp:label runat="server" id="Location3CompanyNameLabel" text='<%# Eval("Location3CompanyName")%>'></asp:label>
                <asp:label runat="server" id="a4ActivityTypeLabel" text='<%# "<br />" + Left(Eval("a4ActivityType"),1) + ":&nbsp;" %>' visible='<%# Eval("a4ActivityType").Length > 1 %>'></asp:label><asp:label runat="server" id="Location4CompanyNameLabel" text='<%# Eval("Location4CompanyName")%>'></asp:label>
                                                                            
        </ItemTemplate></asp:TemplateField>



            <asp:TemplateField><ItemTemplate>
                <asp:Button class="btn btn-sm btn-default" ID="EditButton" runat="server" Text="Edit" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="EditButton_Click" ToolTip="Edit this order" />
                <asp:Button class="btn btn-sm btn-default" ID="PrintButton" runat="server" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="PrintButton_Click" Text="LCS" toolTip="Print Load Confirmation Sheet"/>
                <asp:Button class="btn btn-sm btn-default" ID="PrintBOLButton" runat="server" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="PrintButton_Click" Text="BOL" toolTip="Print Bill of Lading"/>
                <asp:Button class="btn btn-sm btn-default" ID="DuplicateButton" runat="server" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="DuplicateButton_Click" Text="Copy" ToolTip="Make a copy of this order with a status of Pending" />
            
                
               <%-- <a id="InvoiceLink" runat="server" class="btn btn-sm btn-default" href="#" onclick="window.open('Invoice.ashx?soid=<%# Eval("ShippingOrderID") %>'); return false;" title="Invoice">Invoice</a>--%>

            
                <asp:Button CssClass="btn btn-sm btn-info" ID="ScanDocButton" CommandArgument='<%# Eval("ShippingOrderID") %>' runat="server"  Text="Scan" Title="Scan or Replace" OnClick="ScanDocButton_Click" />
                                <asp:HiddenField runat="server" ID="BackupDocPathHiddenField" Value='<%# Eval("BackupDocPath") %>' />
<asp:Button CssClass="btn btn-sm btn-success" ID="EnabledViewButton" OnClientClick='<%# String.Format("OpenImage({0});", Eval("ShippingOrderID")) %>'  runat="server" Text="View"  />

               

            
            </ItemTemplate></asp:TemplateField>
        </Columns>
       <%-- <FooterStyle BackColor="#CCCCCC" />
        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />--%>
        <EmptyDataTemplate>
            There are no Orders matching the selected status.
        </EmptyDataTemplate>
    </asp:GridView>

     <script>
        function OpenImage(soid) {
            var url = "ImageViewer.ashx?soid=" + soid;
            window.open(url);
            return false;
        }
    </script>
    
    <asp:SqlDataSource ID="ShippingOrdersSqlDataSource" CancelSelectOnNullParameter="False" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT  ShippingOrder.ShippingOrderID ,
        ShippingOrder.CustomerCompanyID ,
        ShippingOrder.CarrierCompanyID ,
        ShippingOrder.CarrierContact ,
        ShippingOrder.CarrierPhone ,
        ShippingOrder.CarrierFax ,
        ShippingOrder.CarrierEmail ,
        ShippingOrder.Notes ,
        ShippingOrder.CustomerPONumber ,
        (ShippingOrder.CustomerBillAmount + isnull(shippingorder.ExtraCharge1Amount,0)) as CustomerBillAmount ,
        (ShippingOrder.CarrierPayAmount + isnull(shippingorder.ExtraPay1Amount,0)) as CarrierPayAmount ,
        ShippingOrder.CarrierDriverName ,
        ShippingOrder.CarrierDriverCell ,
        ShippingOrder.a1CommodityType as CommodityType ,
        ShippingOrder.LoadType ,
        ShippingOrder.PORequested, 
        ShippingOrder.Tarp ,
        ShippingOrder.Weight ,
        ShippingOrder.StatusType ,
        Customer.CompanyName AS CustomerName ,
        Carrier.CompanyName AS CarrierName ,
        '' AS Pickup ,
        '' AS Delivery,
		 ( SELECT    CompanyName + ' (' + ISNULL(bCity, 'Unknown City') + ', '
                    + ISNULL(bState, 'Unknown State') + ')' AS CompanyName
          FROM      Company
          WHERE     Id = ShippingOrder.CustomerCompanyID
        ) AS CustomerCompanyName ,
        ( SELECT    CompanyName + ' (' + ISNULL(bCity, 'Unknown City') + ', '
                    + ISNULL(bState, 'Unknown State') + ')' AS CompanyName
          FROM      Company
          WHERE     Id = ShippingOrder.CarrierCompanyID
        ) AS CarrierCompanyName ,
        ( SELECT    CompanyName + ' (' + ISNULL(sCity, 'Unknown City') + ', '
                    + ISNULL(sState, 'Unknown State') + ')' AS CompanyName
          FROM      Company
          WHERE     Id = ShippingOrder.a1LocationCompanyID
        ) AS Location1CompanyName ,
        ( SELECT    CompanyName + ' (' + ISNULL(sCity, 'Unknown City') + ', '
                    + ISNULL(sState, 'Unknown State') + ')' AS CompanyName
          FROM      Company
          WHERE     Id = ShippingOrder.a2LocationCompanyID
        ) AS Location2CompanyName ,
        ( SELECT    CompanyName + ' (' + ISNULL(sCity, 'Unknown City') + ', '
                    + ISNULL(sState, 'Unknown State') + ')' AS CompanyName
          FROM      Company
          WHERE     Id = ShippingOrder.a3LocationCompanyID
        ) AS Location3CompanyName ,
        ( SELECT    CompanyName + ' (' + ISNULL(sCity, 'Unknown City') + ', '
                    + ISNULL(sState, 'Unknown State') + ')' AS CompanyName
          FROM      Company
          WHERE     Id = ShippingOrder.a4LocationCompanyID
        ) AS Location4CompanyName, OrderNumber, ShippingOrder.BackupDocPath, a1ActivityType, a2ActivityType, a3ActivityType, a4ActivityType, OrderDate, isnull(Priority,0) Priority
FROM    Company AS Customer
        INNER JOIN ShippingOrder ON Customer.Id = ShippingOrder.CustomerCompanyID
        LEFT OUTER JOIN Company AS Carrier ON ShippingOrder.CarrierCompanyID = Carrier.Id
WHERE   (((ShippingOrder.StatusType = @StatusType and @StatusType &lt;&gt; 'Assigned') or (@StatusType = 'Assigned' and OrderDate between @StartDate and @EndDate ))) or (@OrderNumber is not null and OrderNumber = @OrderNumber) or (@CarrierCompanyID is not null and CarrierCompanyID = @CarrierCompanyID)   order by OrderNumber">
        <SelectParameters>
            <asp:ControlParameter ControlID="OrderStatusDropDownList" Name="StatusType" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="StartDateTextBox" Name="StartDate" PropertyName="text" />
            <asp:ControlParameter ControlID="EndDateTextBox" Name="EndDate" PropertyName="text" />
            <asp:ControlParameter ControlID="OrderNumberTextBox" Name="OrderNumber" PropertyName="text" />
            <asp:ControlParameter ControlID="CarrierDropDownList" Name="CarrierCompanyID" PropertyName="SelectedValue" />
        </SelectParameters>
</asp:SqlDataSource>
    
    <br />
    <br />
<asp:Button runat="server" ID="NewOrderButton" Text="New Order" />
</asp:Content>
