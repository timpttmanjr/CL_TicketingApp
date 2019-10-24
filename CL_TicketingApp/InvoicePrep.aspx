<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="InvoicePrep.aspx.vb" Inherits="CL_TicketingApp.InvoicePrep" %>



<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Invoice Queue</h1>
    <br />
    <table>
    
        <tr>
             <td>Customer is</td>
            <td><asp:DropDownList ToolTip="Customers with unbilled orders" ID="CustomerDropDownList" CssClass="form-control input-sm"  runat="server" DataSourceID="CompanySqlDataSource" DataTextField="CompanyName" DataValueField="ID"></asp:DropDownList></td>
           <td> and delivery date is between</td>
            <td><asp:TextBox ID="StartDateTextBox" runat="server" CssClass="form-control input-sm" width="95px"></asp:TextBox></td>
            <td>and</td>
            <td><asp:TextBox ID="EndDateTextBox" runat="server" CssClass="form-control input-sm" width="95px"></asp:TextBox></td>
            <td><asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="btn btn-sm" /></td>
            <td>&nbsp;<asp:Button ID="ExportButton" runat="server" Text="Export to Excel [xml]" /></td>
        </tr>
    </table>
    <asp:SqlDataSource ID="CompanySqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT c.id, c.CompanyName, CASE WHEN c.CompanyName LIKE '%Sunbelt%' THEN -1 ELSE 1 END AS DisplayOrder FROM company c JOIN shippingorder so ON so.CustomerCompanyID = c.Id WHERE StatusType IN ('Pending','Assigned','Complete') AND so.OrderDate > '1/1/2018' AND c.CompanyName IS NOT NULL ORDER BY CASE WHEN c.CompanyName LIKE '%Sunbelt%' THEN -1 ELSE 1 END,c.CompanyName"></asp:SqlDataSource>


    <cc1:calendarextender ID="StartDateTextBoxCalendarExtender" PopupButtonID="StartDateTextBox" TargetControlID="StartDateTextBox" runat="server" />
    <cc1:calendarextender ID="EndDateTextBoxCalendarExtender" PopupButtonID="EndDateTextBox" TargetControlID="EndDateTextBox" runat="server" />
    
    <p></p>    <br />

    <asp:Button ID="BatchOfPORsButton" runat="server" Text="Batch PO Requests" ToolTip="Print PORs for all selected items" OnClick="BatchOfPORsButton_Click" CssClass="btn btn-default" />
    <asp:Button ID="BatchOfInvoicesButton" runat="server" Text="Batch Invoices" ToolTip="Print Invoices for all selected items" OnClick="BatchOfInvoicesButton_Click" CssClass="btn btn-default" />
    <asp:Repeater runat="server" ID="QueueRepeater" DataSourceID="QueueSqlDataSource">
        <HeaderTemplate>
            <table width="100%" class="table table-hover table-striped table-condensed" >
                    
         <thead>
             <tr   >
                 <td></td>
            <td >Order</td>
                 <td >Customer</td>

     <%--       <td >Date</td>--%>
          <%--  <td >Shipper</td>--%>
            <td >Origin</td>
           
       <%--     <td >Consignee</td>--%>
            <td >Destination</td>
            
            <td >Weight</td>
            <td >Amount</td>
            <%--<td >Extra</td>--%>
            <td >Shipped</td>
            <td >Delivered</td>
            <td >PO</td>
    <%--        <td >PO Req.</td>--%>
            <td >BOL</td>
                 <td></td>
            <td ></td>
            <td ></td>
            <td ></td>
        </tr>
                </thead><tbody>
        </HeaderTemplate>
        <ItemTemplate>
          <asp:UpdatePanel runat="server" ID="RowUpdatePanel" ChildrenAsTriggers="true">
              <ContentTemplate>


            <tr  >
                <td><asp:CheckBox runat="server" ID="SelectedItemCheckBox" /></td>
              <td>
                 <asp:HyperLink CssClass="small" runat="server" ID="OrderHyperLink" Target="_blank" NavigateUrl='<%#String.Format("~/NewOrder.aspx?soid={0}", Eval("OrderNumber")) %>'><%# Eval("OrderNumber") %></asp:HyperLink>
                  
                  </td>
            <td><%# Eval("CompanyName") %>
                <asp:HiddenField ID="ShippingOrderIDHiddenField" runat="server" Value=' <%# Eval("ShippingOrderID") %>' />
                </td>
          
            <%--<td><%# Eval("OrderDate") %></td>--%>
         <%--   <td><%# Eval("Shipper") %></td>--%>
            <td>
                
                <div title='<%# Eval("OriginAddress") %>, <%# Eval("OriginCity") %>, <%# Eval("OriginState") %>, <%# Eval("OriginPostalCode") %>'>
                    <%# Eval("Shipper") %><br /><%# Eval("OriginCity") %>, <%# Eval("OriginState") %>
                </div>
            </td>

            <%--<td><%# Eval("Consignee") %></td>--%>
            <td>
                
                <div title='<%# Eval("DestinationAddress") %>, <%# Eval("DestinationCity") %>, <%# Eval("DestinationState") %>, <%# Eval("DestinationPostalCode") %>'>
                    <%# Eval("Consignee") %><br /><%# Eval("DestinationCity") %>, <%# Eval("DestinationState") %>
                </div>
            </td>
            <td><%# Eval("Weight") %></td>
            <td><%# decimal.Round(Decimal.Parse(Eval("CustomerBillAmount"))) + Decimal.Round(Decimal.Parse(Eval("ExtraCharge1Amount"))) %>

<%--                <asp:Label ID="ExtraCharge" runat="server" Text='<%# decimal.Round(Decimal.Parse(Eval("ExtraCharge1Amount"))) %>'></asp:Label>--%>

               


            </td>
           <%-- <td><%# decimal.Round(Decimal.Parse(Eval("ExtraCharge1Amount"))) %></td>--%>
            <td><%# Eval("ShipDate") %></td>
            <td><%# Eval("DeliveryDate") %></td>
            <td>
               
                <asp:TextBox CssClass="form-control input-sm" width="75px" runat="server" ID="POTextBox" Text='<%# Eval("PO") %>'></asp:TextBox>
                <br />
                <%# Eval("PORequested") %>

            </td>
<%--            <td><%# Eval("PORequested") %></td>--%>
            <td ><asp:TextBox CssClass="form-control input-sm" width="75px" runat="server" ID="BOLTextBox" Text='<%# Eval("BOL") %>'></asp:TextBox></td>
           <td>
               <asp:Button runat="server" ID="SaveButton" CssClass="btn btn-sm btn-default" Text="Update" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="SaveButton_Click" />
           </td>
                <td>

                <a class="btn btn-sm btn-primary" href="#" onclick="window.open('POrequest.ashx?soid=<%# Eval("ShippingOrderID") %>'); return false;" title="PO Request">POR</a>
                

               <%-- <asp:Button CssClass="btn btn-sm btn-primary" ID="PrintPORequestButton" runat="server" Text="POR" CommandArgument='<%# Eval("ShippingOrderID") %>'/>--%>
                </td>
                <td>
                <a class="btn btn-sm btn-primary" href="#" onclick="window.open('Invoice.ashx?soid=<%# Eval("ShippingOrderID") %>'); return false;" title="Invoice">Invoice</a>



                </td>
                <td>

                <asp:Button CssClass="btn btn-sm btn-info" ID="ScanDocButton" CommandArgument='<%# Eval("ShippingOrderID") %>' runat="server"  Text="Scan" Title="Scan or Replace" OnClick="ScanDocButton_Click" />
                <asp:HiddenField runat="server" ID="BackupDocPathHiddenField" Value='<%# Eval("BackupDocPath") %>' />
                </td>
                <td >
                <asp:Button CssClass="btn btn-sm btn-success" ID="EnabledViewButton" OnClientClick='<%# String.Format("OpenImage({0});", Eval("ShippingOrderID")) %>'  runat="server" Text="View"  />
                </td>

        </tr>
                          </ContentTemplate>
          </asp:UpdatePanel>
        </ItemTemplate>
        <FooterTemplate>
            </tbody></table>
        </FooterTemplate>
    </asp:Repeater>

    <script>
        function OpenImage(soid) {
            var url = "ImageViewer.ashx?soid=" + soid;
            window.open(url);
            return false;
        }
    </script>

    <br />
    <br />
    <br />
    <br />
    <br />
    <br />

    <asp:SqlDataSource CancelSelectOnNullParameter="false" ID="QueueSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShippingOrderQueue_InvoicePrep" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="StartDate" Type="DateTime" />
            <asp:Parameter Name="EndDate" Type="DateTime" />
            <asp:Parameter Name="Customer" Type="String" />
            <asp:Parameter Name="CustomerCompanyID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />

</asp:Content>
