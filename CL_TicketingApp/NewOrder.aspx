<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="NewOrder.aspx.vb" Inherits="CL_TicketingApp.NewOrder" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="AddActivityWebUserControl.ascx" TagName="AddActivityWebUserControl" TagPrefix="uc1" %>
<%@ Register Src="~/CompanyPopupWrapperWebUserControl.ascx" TagPrefix="uc1" TagName="CompanyPopupWrapperWebUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="ShippingOrderIDHiddenField" runat="server" />
    
    <%--<asp:ImageButton ID="NewCarrierImageButton" runat="server" AlternateText="New Carrier" ImageUrl="~/Images/plus1.gif" />--%>

    <script type="text/javascript">
        <%--function CustomerItemSelected(sender, e) {
            $get("<%=CustomerIDHiddenField.ClientID%>").value = e.get_value();
    }--%>
    function CarrierItemSelected(sender, e) {
        $get("<%=CarrierIDHiddenField.ClientID%>").value = e.get_value();
    }
    </script>
    <h1>New Order</h1>
    <br />

    <h4>Order and Customer Information</h4>
    <table>
        <tr>
            <td>Status</td>
            <td>
                <asp:DropDownList ID="OrderStatusDropDownList" runat="server" DataSourceID="OrderStatusSqlDataSource" DataTextField="Value" DataValueField="Value" AutoPostBack="True" TabIndex="1"></asp:DropDownList>
                <asp:SqlDataSource ID="OrderStatusSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="Select Value from l where Category = 'Order Status'"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>Order</td>
            <td>
                <asp:TextBox runat="server" ID="ShippingOrderNumberTextBox" Enabled="false" TabIndex="2">[Auto]</asp:TextBox></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>Date</td>
            <td>
                <asp:TextBox runat="server" ID="OrderDateTextBox" Enabled="false" TabIndex="3">[Auto]</asp:TextBox></td>
            <td></td>
        </tr>
        <tr>
            <td>Customer</td>
            <td>
                <asp:UpdatePanel ID="CustomerSelectorUpdatePanel" runat="server" UpdateMode="Always">
                    <ContentTemplate>
<%--                        <asp:TextBox ID="CustomerTextBox" runat="server" Width="350px" AutoPostBack="true" TabIndex="4"></asp:TextBox><uc1:CompanyPopupWrapperWebUserControl runat="server" ID="NewCustomerPopupControl" isVendor="false" isCustomer="true" />
                        <asp:Label ID="CustomerNumberLabel" runat="server"></asp:Label>
                        <cc1:AutoCompleteExtender ServiceMethod="SearchCustomers"
                            MinimumPrefixLength="1"
                            CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                            TargetControlID="CustomerTextBox"
                            ID="CustomerAutoCompleteExtender" runat="server" FirstRowSelected="false" OnClientItemSelected="CustomerItemSelected">
                        </cc1:AutoCompleteExtender>--%>
                <asp:DropDownList ID="CustomerDropDownList" runat="server" DataSourceID="CompanySqlDataSource" DataTextField="CompanyName" DataValueField="ID"></asp:DropDownList>&nbsp;
                <%--<asp:ImageButton ID="NewCustomerImageButton" runat="server" AlternateText="New Customer" ImageUrl="~/Images/plus1.gif" />--%>

                    </ContentTemplate>
                </asp:UpdatePanel>
</td>
            <td></td>
        </tr>
        <tr>
            <td>Contact</td>
            <td>
                <asp:TextBox runat="server" ID="CustomerContactTextBox" Columns="60" TabIndex="4"></asp:TextBox></td>
            <td>&nbsp;</td>
        </tr>

        <tr>
            <td>Bill Amount</td>
            <td>
                <asp:TextBox runat="server" ID="CustomerBillAmount" Columns="60" TabIndex="4"></asp:TextBox></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>Extra Charge</td>
            <td>
                <asp:TextBox ID="ExtraCharge1AmountTextBox" runat="server" TabIndex="5"></asp:TextBox></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>Extra Charge Description</td>
            <td>
                <asp:TextBox ID="ExtraCharge1DescriptionTextBox" runat="server" Width="323px" TabIndex="6"></asp:TextBox>
            </td>
        </tr>
    </table>

    <h4>Carrier</h4>
    <asp:UpdateProgress id="updateProgress" runat="server" AssociatedUpdatePanelID="CarrierSelectorUpdatePanel">
    <ProgressTemplate>
        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
            <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #FFFFFF; font-size: 36px; left: 40%; top: 40%;">Loading Carrier...</span>
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>
    <asp:UpdatePanel ID="CarrierSelectorUpdatePanel" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                        <table width="100%">
        <tr>
            <td>Carrier</td>
            <td>
                <asp:HiddenField ID="CarrierIDHiddenField" runat="server" />
                        <asp:TextBox ID="CarrierTextBox" runat="server" Width="650px" AutoPostBack="true" TabIndex="61"></asp:TextBox>
                        <uc1:CompanyPopupWrapperWebUserControl runat="server" ID="NewCarrierPopUpControl" />
                        <%--<asp:ImageButton ID="NewCarrierImageButton" runat="server" AlternateText="New Carrier" ImageUrl="~/Images/plus1.gif" />--%>
                        <asp:Label ID="CarrierNumberLabel" runat="server"></asp:Label>
                        <cc1:AutoCompleteExtender ServiceMethod="SearchCarriers"
                            MinimumPrefixLength="2"
                            CompletionInterval="100" EnableCaching="false" CompletionSetCount="50"
                            TargetControlID="CarrierTextBox"
                            ID="CarrierAutoCompleteExtender" runat="server" FirstRowSelected="false" OnClientItemSelected="CarrierItemSelected">
                        </cc1:AutoCompleteExtender>

                   
                <asp:SqlDataSource ID="CompanySqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT CompanyName, id FROM Company where customer = 1 and isnull(disabled,0) = 0 ORDER BY CompanyName"></asp:SqlDataSource>
            </td>
            <td>Rate</td>
            <td>
                <asp:TextBox ID="CarrierPayAmountTextBox" runat="server" TextMode="Number" TabIndex="86"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Contact</td>
            <td>
                <asp:TextBox ID="CarrierContactTextBox" runat="server" TabIndex="80"></asp:TextBox></td>
            <td>Extra Pay</td>
            <td>
                <asp:TextBox ID="ExtraPay1AmountTextBox" runat="server" TabIndex="87" TextMode="Number"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Phone</td>
            <td>
                <asp:TextBox ID="CarrierPhoneTextBox" runat="server" TextMode="Phone" TabIndex="81"></asp:TextBox></td>
            <td>Extra Pay Description</td>
            <td>
                <asp:TextBox ID="ExtraPay1DescriptionTextBox" runat="server" TabIndex="88" Width="323px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Fax</td>
            <td>
                <asp:TextBox ID="CarrierFaxTextBox" runat="server" TextMode="Phone" TabIndex="82"></asp:TextBox></td>
            <td>Contact</td>
            <td>
                <asp:TextBox ID="CitationContactTextBox" runat="server" TabIndex="89"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Email</td>
            <td>
                <asp:TextBox ID="EmailTextBox" runat="server" TextMode="Email" TabIndex="83"></asp:TextBox></td>
            <td>Load Type</td>
            <td>
                <asp:DropDownList ID="LoadTypeDropDownList" runat="server" DataSourceID="LoadTypeSqlDataSource" DataTextField="Value" DataValueField="Value" TabIndex="90">
                </asp:DropDownList>
                <asp:SqlDataSource ID="LoadTypeSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="select value from l where category = 'Equipment' order by displayorder, value"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Driver Name</td>
            <td>
                <asp:TextBox ID="DriverNameTextBox" runat="server" TabIndex="84"></asp:TextBox></td>
            <td>Tarp</td>
            <td>
                <asp:DropDownList ID="TarpDropDownList" runat="server" TabIndex="91">
                    <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                    <asp:ListItem Text="No" Value="No" Selected="true"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>Cell Phone</td>
            <td>
                <asp:TextBox ID="CellPhoneTextBox" runat="server" TextMode="Phone" TabIndex="85"></asp:TextBox></td>
            <td>Weight</td>
            <td>
                <asp:TextBox ID="WeightTextBox" runat="server" TabIndex="92"></asp:TextBox>
            </td>
        </tr>
    </table>
                         </ContentTemplate>
                </asp:UpdatePanel>
    <br />
    <h4>Pickup / Delivery 1</h4>
    <br />
    <uc1:AddActivityWebUserControl ID="AddActivityWebUserControl1" runat="server" ActivityItem="a1" />
    <br />
    <h4>Pickup / Delivery 2</h4>
    <uc1:AddActivityWebUserControl ID="AddActivityWebUserControl2" runat="server" ActivityItem="a2" />
    <br />
    <h4>Pickup / Delivery 3</h4>
    <uc1:AddActivityWebUserControl ID="AddActivityWebUserControl3" runat="server" ActivityItem="a3" />
    <br />
    <h4>Pickup / Delivery 4</h4>
    <uc1:AddActivityWebUserControl ID="AddActivityWebUserControl4" runat="server" ActivityItem="a4"  />





    <h4>Notes</h4>
    <asp:TextBox ID="NotesTextBox" runat="server" Rows="10" Width="90%" TextMode="MultiLine" TabIndex="500"></asp:TextBox>
    <br />
    <asp:SqlDataSource ID="OrdersSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
        DeleteCommand="DELETE FROM [ShippingOrder] WHERE [ShippingOrderID] = @ShippingOrderID" 
        InsertCommand="INSERT INTO [ShippingOrder] ([CustomerCompanyID], [CarrierCompanyID], [CarrierContact], [CarrierPhone], [CarrierFax], [CarrierEmail], [Notes], [CustomerPONumber], [CustomerBillAmount], [CarrierPayAmount], [CarrierDriverName], [CarrierDriverCell], [CommodityType], [LoadType], [Tarp], [Weight], [StatusType], [CitationContact], [OrderNumber], [OrderDate], [a1ActivityType], [a1LocationCompanyID], [a1Address1], [a1Address2], [a1City], [a1State], [a1PostalCode], [a1Notes], [a1CompletionDate], [a1Status], [a1ActivityDate], [a1CommodityType], [a1Phone], [a2ActivityType], [a2LocationCompanyID], [a2Address1], [a2Address2], [a2City], [a2State], [a2PostalCode], [a2Notes], [a2CompletionDate], [a2Status], [a2ActivityDate], [a2CommodityType], [a2Phone], [a3ActivityType], [a3LocationCompanyID], [a3Address1], [a3Address2], [a3City], [a3State], [a3PostalCode], [a3Notes], [a3CompletionDate], [a3Status], [a3ActivityDate], [a3CommodityType], [a3Phone], [a4ActivityType], [a4LocationCompanyID], [a4Address1], [a4Address2], [a4City], [a4State], [a4PostalCode], [a4Notes], [a4CompletionDate], [a4Status], [a4ActivityDate], [a4CommodityType], [a4Phone], a1Contact, a2Contact, a3Contact, a4Contact, a1ActivityTime, a2ActivityTime, a3ActivityTime, a4ActivityTime, ExtraCharge1Amount, ExtraCharge1Description, ExtraPay1Amount, ExtraPay1Description,a1ActivityTimeEnd ,a2ActivityTimeEnd ,a3ActivityTimeEnd , a4ActivityTimeEnd ,CustomerContact) VALUES (@CustomerCompanyID, @CarrierCompanyID, @CarrierContact, @CarrierPhone, @CarrierFax, @CarrierEmail, @Notes, @CustomerPONumber, @CustomerBillAmount, @CarrierPayAmount, @CarrierDriverName, @CarrierDriverCell, @CommodityType, @LoadType, @Tarp, @Weight, @StatusType, @CitationContact, @OrderNumber, @OrderDate, @a1ActivityType, @a1LocationCompanyID, @a1Address1, @a1Address2, @a1City, @a1State, @a1PostalCode, @a1Notes, @a1CompletionDate, @a1Status, @a1ActivityDate, @a1CommodityType, @a1Phone, @a2ActivityType, @a2LocationCompanyID, @a2Address1, @a2Address2, @a2City, @a2State, @a2PostalCode, @a2Notes, @a2CompletionDate, @a2Status, @a2ActivityDate, @a2CommodityType, @a2Phone, @a3ActivityType, @a3LocationCompanyID, @a3Address1, @a3Address2, @a3City, @a3State, @a3PostalCode, @a3Notes, @a3CompletionDate, @a3Status, @a3ActivityDate, @a3CommodityType, @a3Phone, @a4ActivityType, @a4LocationCompanyID, @a4Address1, @a4Address2, @a4City, @a4State, @a4PostalCode, @a4Notes, @a4CompletionDate, @a4Status, @a4ActivityDate, @a4CommodityType, @a4Phone, @a1Contact, @a2Contact, @a3Contact, @a4Contact, @a1ActivityTime, @a2ActivityTime, @a3ActivityTime, @a4ActivityTime, @ExtraCharge1Amount, @ExtraCharge1Description, @ExtraPay1Amount, @ExtraPay1Description,@a1ActivityTimeEnd ,@a2ActivityTimeEnd ,@a3ActivityTimeEnd , @a4ActivityTimeEnd ,@CustomerContact)" 
        SelectCommand="SELECT * FROM [ShippingOrder] WHERE ([ShippingOrderID] = @ShippingOrderID)" 
        UpdateCommand="UPDATE [ShippingOrder] SET [CustomerCompanyID] = @CustomerCompanyID, [CarrierCompanyID] = @CarrierCompanyID, [CarrierContact] = @CarrierContact, [CarrierPhone] = @CarrierPhone, [CarrierFax] = @CarrierFax, [CarrierEmail] = @CarrierEmail, [Notes] = @Notes, [CustomerPONumber] = @CustomerPONumber, [CustomerBillAmount] = @CustomerBillAmount, [CarrierPayAmount] = @CarrierPayAmount, [CarrierDriverName] = @CarrierDriverName, [CarrierDriverCell] = @CarrierDriverCell, [CommodityType] = @CommodityType, [LoadType] = @LoadType, [Tarp] = @Tarp, [Weight] = @Weight, [StatusType] = @StatusType, [CitationContact] = @CitationContact, [OrderNumber] = @OrderNumber, [OrderDate] = @OrderDate, [a1ActivityType] = @a1ActivityType, [a1LocationCompanyID] = @a1LocationCompanyID, [a1Address1] = @a1Address1, [a1Address2] = @a1Address2, [a1City] = @a1City, [a1State] = @a1State, [a1PostalCode] = @a1PostalCode, [a1Notes] = @a1Notes, [a1CompletionDate] = @a1CompletionDate, [a1Status] = @a1Status, [a1ActivityDate] = @a1ActivityDate, [a1CommodityType] = @a1CommodityType, [a1Phone] = @a1Phone, [a2ActivityType] = @a2ActivityType, [a2LocationCompanyID] = @a2LocationCompanyID, [a2Address1] = @a2Address1, [a2Address2] = @a2Address2, [a2City] = @a2City, [a2State] = @a2State, [a2PostalCode] = @a2PostalCode, [a2Notes] = @a2Notes, [a2CompletionDate] = @a2CompletionDate, [a2Status] = @a2Status, [a2ActivityDate] = @a2ActivityDate, [a2CommodityType] = @a2CommodityType, [a2Phone] = @a2Phone, [a3ActivityType] = @a3ActivityType, [a3LocationCompanyID] = @a3LocationCompanyID, [a3Address1] = @a3Address1, [a3Address2] = @a3Address2, [a3City] = @a3City, [a3State] = @a3State, [a3PostalCode] = @a3PostalCode, [a3Notes] = @a3Notes, [a3CompletionDate] = @a3CompletionDate, [a3Status] = @a3Status, [a3ActivityDate] = @a3ActivityDate, [a3CommodityType] = @a3CommodityType, [a3Phone] = @a3Phone, [a4ActivityType] = @a4ActivityType, [a4LocationCompanyID] = @a4LocationCompanyID, [a4Address1] = @a4Address1, [a4Address2] = @a4Address2, [a4City] = @a4City, [a4State] = @a4State, [a4PostalCode] = @a4PostalCode, [a4Notes] = @a4Notes, [a4CompletionDate] = @a4CompletionDate, [a4Status] = @a4Status, [a4ActivityDate] = @a4ActivityDate, [a4CommodityType] = @a4CommodityType, [a4Phone] = @a4Phone, a1contact = @a1Contact, a2Contact = @a2Contact, a3Contact = @a3Contact, a4Contact = @a4Contact, a1ActivityTime = @a1ActivityTime, a2ActivityTime = @a2ActivityTime, a3ActivityTime = @a3ActivityTime, a4ActivityTime = @a4ActivityTime, ExtraCharge1Amount = @ExtraCharge1Amount, ExtraCharge1Description = @ExtraCharge1Description, ExtraPay1Amount = @ExtraPay1Amount, ExtraPay1Description = @ExtraPay1Description,[a1ActivityTimeEnd] = @a1ActivityTimeEnd,[a2ActivityTimeEnd] = @a2ActivityTimeEnd, [a3ActivityTimeEnd] = @a3ActivityTimeEnd,[a4ActivityTimeEnd] = @a4ActivityTimeEnd,[CustomerContact] = @CustomerContact WHERE [ShippingOrderID] = @ShippingOrderID">
        <DeleteParameters>
            <asp:Parameter Name="ShippingOrderID"  />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerCompanyID"  />
            <asp:Parameter Name="CarrierCompanyID"  />
            <asp:Parameter Name="CarrierContact" Type="String" />
            <asp:Parameter Name="CarrierPhone" Type="String" />
            <asp:Parameter Name="CarrierFax" Type="String" />
            <asp:Parameter Name="CarrierEmail" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="CustomerPONumber" Type="String" />
            <asp:Parameter Name="CustomerBillAmount"  />
            <asp:Parameter Name="CarrierPayAmount"  />
            <asp:Parameter Name="CarrierDriverName" Type="String" />
            <asp:Parameter Name="CarrierDriverCell" Type="String" />
            <asp:Parameter Name="CommodityType" Type="String" />
            <asp:Parameter Name="LoadType" Type="String" />
            <asp:Parameter Name="Tarp" Type="String" />
            <asp:Parameter Name="Weight" Type="String" />
            <asp:Parameter Name="StatusType" Type="String" />
            <asp:Parameter Name="CitationContact" Type="String" />
            <asp:Parameter Name="OrderNumber"  />
            <asp:Parameter DbType="Date" Name="OrderDate" />
            <asp:Parameter Name="a1ActivityType" Type="String" />
            <asp:Parameter Name="a1LocationCompanyID"  />
            <asp:Parameter Name="a1Address1" Type="String" />
            <asp:Parameter Name="a1Address2" Type="String" />
            <asp:Parameter Name="a1City" Type="String" />
            <asp:Parameter Name="a1State" Type="String" />
            <asp:Parameter Name="a1PostalCode" Type="String" />
            <asp:Parameter Name="a1Notes" Type="String" />
            <asp:Parameter Name="a1CompletionDate"  />
            <asp:Parameter Name="a1Status" Type="String" />
            <asp:Parameter Name="a1ActivityDate" Type="String" />
            <asp:Parameter Name="a1CommodityType" Type="String" />
            <asp:Parameter Name="a1Phone" Type="String" />
            <asp:Parameter Name="a2ActivityType" Type="String" />
            <asp:Parameter Name="a2LocationCompanyID"  />
            <asp:Parameter Name="a2Address1" Type="String" />
            <asp:Parameter Name="a2Address2" Type="String" />
            <asp:Parameter Name="a2City" Type="String" />
            <asp:Parameter Name="a2State" Type="String" />
            <asp:Parameter Name="a2PostalCode" Type="String" />
            <asp:Parameter Name="a2Notes" Type="String" />
            <asp:Parameter Name="a2CompletionDate"  />
            <asp:Parameter Name="a2Status" Type="String" />
            <asp:Parameter Name="a2ActivityDate" Type="String" />
            <asp:Parameter Name="a2CommodityType" Type="String" />
            <asp:Parameter Name="a2Phone" Type="String" />
            <asp:Parameter Name="a3ActivityType" Type="String" />
            <asp:Parameter Name="a3LocationCompanyID"  />
            <asp:Parameter Name="a3Address1" Type="String" />
            <asp:Parameter Name="a3Address2" Type="String" />
            <asp:Parameter Name="a3City" Type="String" />
            <asp:Parameter Name="a3State" Type="String" />
            <asp:Parameter Name="a3PostalCode" Type="String" />
            <asp:Parameter Name="a3Notes" Type="String" />
            <asp:Parameter Name="a3CompletionDate"  />
            <asp:Parameter Name="a3Status" Type="String" />
            <asp:Parameter Name="a3ActivityDate" Type="String" />
            <asp:Parameter Name="a3CommodityType" Type="String" />
            <asp:Parameter Name="a3Phone" Type="String" />
            <asp:Parameter Name="a4ActivityType" Type="String" />
            <asp:Parameter Name="a4LocationCompanyID"  />
            <asp:Parameter Name="a4Address1" Type="String" />
            <asp:Parameter Name="a4Address2" Type="String" />
            <asp:Parameter Name="a4City" Type="String" />
            <asp:Parameter Name="a4State" Type="String" />
            <asp:Parameter Name="a4PostalCode" Type="String" />
            <asp:Parameter Name="a4Notes" Type="String" />
            <asp:Parameter Name="a4CompletionDate"  />
            <asp:Parameter Name="a4Status" Type="String" />
            <asp:Parameter Name="a4ActivityDate" Type="String" />
            <asp:Parameter Name="a4CommodityType" Type="String" />
            <asp:Parameter Name="a4Phone" Type="String" />
            <asp:Parameter Name="a1Contact" Type="String" />
            <asp:Parameter Name="a2Contact" Type="String" />
            <asp:Parameter Name="a3Contact" Type="String" />
            <asp:Parameter Name="a4Contact" Type="String" />
            <asp:Parameter Name="a1ActivityTime" Type="String" />
            <asp:Parameter Name="a2ActivityTime" Type="String" />
            <asp:Parameter Name="a3ActivityTime" Type="String" />
            <asp:Parameter Name="a4ActivityTime" Type="String" />
            <asp:Parameter Name="ExtraCharge1Amount" Type="String" />
            <asp:Parameter Name="ExtraCharge1Description" Type="String" />
            <asp:Parameter Name="ExtraPay1Amount" Type="String" />
            <asp:Parameter Name="ExtraPay1Description" Type="String" />
            <asp:Parameter Name="a1ActivityTimeEnd" Type="String" />
            <asp:Parameter Name="a2ActivityTimeEnd" Type="String" />
            <asp:Parameter Name="a3ActivityTimeEnd" Type="String" />
            <asp:Parameter Name="a4ActivityTimeEnd" Type="String" />
            <asp:Parameter Name="CustomerContact" Type="String" />
            
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="ShippingOrderID" QueryStringField="id"  />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustomerCompanyID"  />
            <asp:Parameter Name="CarrierCompanyID"  />
            <asp:Parameter Name="CarrierContact" Type="String" />
            <asp:Parameter Name="CarrierPhone" Type="String" />
            <asp:Parameter Name="CarrierFax" Type="String" />
            <asp:Parameter Name="CarrierEmail" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="CustomerPONumber" Type="String" />
            <asp:Parameter Name="CustomerBillAmount"  />
            <asp:Parameter Name="CarrierPayAmount"  />
            <asp:Parameter Name="CarrierDriverName" Type="String" />
            <asp:Parameter Name="CarrierDriverCell" Type="String" />
            <asp:Parameter Name="CommodityType" Type="String" />
            <asp:Parameter Name="LoadType" Type="String" />
            <asp:Parameter Name="Tarp" Type="String" />
            <asp:Parameter Name="Weight" Type="String" />
            <asp:Parameter Name="StatusType" Type="String" />
            <asp:Parameter Name="CitationContact" Type="String" />
            <asp:Parameter Name="OrderNumber"  />
            <asp:Parameter DbType="Date" Name="OrderDate" />
            <asp:Parameter Name="a1ActivityType" Type="String" />
            <asp:Parameter Name="a1LocationCompanyID"  />
            <asp:Parameter Name="a1Address1" Type="String" />
            <asp:Parameter Name="a1Address2" Type="String" />
            <asp:Parameter Name="a1City" Type="String" />
            <asp:Parameter Name="a1State" Type="String" />
            <asp:Parameter Name="a1PostalCode" Type="String" />
            <asp:Parameter Name="a1Notes" Type="String" />
            <asp:Parameter Name="a1CompletionDate"  />
            <asp:Parameter Name="a1Status" Type="String" />
            <asp:Parameter Name="a1ActivityDate" Type="String" />
            <asp:Parameter Name="a1CommodityType" Type="String" />
            <asp:Parameter Name="a1Phone" Type="String" />
            <asp:Parameter Name="a2ActivityType" Type="String" />
            <asp:Parameter Name="a2LocationCompanyID"  />
            <asp:Parameter Name="a2Address1" Type="String" />
            <asp:Parameter Name="a2Address2" Type="String" />
            <asp:Parameter Name="a2City" Type="String" />
            <asp:Parameter Name="a2State" Type="String" />
            <asp:Parameter Name="a2PostalCode" Type="String" />
            <asp:Parameter Name="a2Notes" Type="String" />
            <asp:Parameter Name="a2CompletionDate"  />
            <asp:Parameter Name="a2Status" Type="String" />
            <asp:Parameter Name="a2ActivityDate" Type="String" />
            <asp:Parameter Name="a2CommodityType" Type="String" />
            <asp:Parameter Name="a2Phone" Type="String" />
            <asp:Parameter Name="a3ActivityType" Type="String" />
            <asp:Parameter Name="a3LocationCompanyID"  />
            <asp:Parameter Name="a3Address1" Type="String" />
            <asp:Parameter Name="a3Address2" Type="String" />
            <asp:Parameter Name="a3City" Type="String" />
            <asp:Parameter Name="a3State" Type="String" />
            <asp:Parameter Name="a3PostalCode" Type="String" />
            <asp:Parameter Name="a3Notes" Type="String" />
            <asp:Parameter Name="a3CompletionDate"  />
            <asp:Parameter Name="a3Status" Type="String" />
            <asp:Parameter Name="a3ActivityDate" Type="String" />
            <asp:Parameter Name="a3CommodityType" Type="String" />
            <asp:Parameter Name="a3Phone" Type="String" />
            <asp:Parameter Name="a4ActivityType" Type="String" />
            <asp:Parameter Name="a4LocationCompanyID"  />
            <asp:Parameter Name="a4Address1" Type="String" />
            <asp:Parameter Name="a4Address2" Type="String" />
            <asp:Parameter Name="a4City" Type="String" />
            <asp:Parameter Name="a4State" Type="String" />
            <asp:Parameter Name="a4PostalCode" Type="String" />
            <asp:Parameter Name="a4Notes" Type="String" />
            <asp:Parameter Name="a4CompletionDate"  />
            <asp:Parameter Name="a4Status" Type="String" />
            <asp:Parameter Name="a4ActivityDate" Type="String" />
            <asp:Parameter Name="a4CommodityType" Type="String" />
            <asp:Parameter Name="a4Phone" Type="String" />
            <asp:Parameter Name="ShippingOrderID"  />
            <asp:Parameter Name="a1Contact" Type="String" />
            <asp:Parameter Name="a2Contact" Type="String" />
            <asp:Parameter Name="a3Contact" Type="String" />
            <asp:Parameter Name="a4Contact" Type="String" />
            <asp:Parameter Name="a1ActivityTime" Type="String" />
            <asp:Parameter Name="a2ActivityTime" Type="String" />
            <asp:Parameter Name="a3ActivityTime" Type="String" />
            <asp:Parameter Name="a4ActivityTime" Type="String" />
            <asp:Parameter Name="ExtraCharge1Amount" Type="String" />
            <asp:Parameter Name="ExtraCharge1Description" Type="String" />
            <asp:Parameter Name="ExtraPay1Amount" Type="String" />
            <asp:Parameter Name="ExtraPay1Description" Type="String" />
            <asp:Parameter Name="a1ActivityTimeEnd" Type="String" />
            <asp:Parameter Name="a2ActivityTimeEnd" Type="String" />
            <asp:Parameter Name="a3ActivityTimeEnd" Type="String" />
            <asp:Parameter Name="a4ActivityTimeEnd" Type="String" />
            <asp:Parameter Name="CustomerContact" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <%--<asp:SqlDataSource ID="OrdersSqlDataSource0" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
        DeleteCommand="DELETE FROM [ShippingOrder] WHERE [ShippingOrderID] = @ShippingOrderID" 
        InsertCommand="INSERT INTO [ShippingOrder] ([CustomerCompanyID], [CarrierCompanyID], [CarrierContact], [CarrierPhone], [CarrierFax], [CarrierEmail], [Notes], [CustomerPONumber], [CustomerBillAmount], [CarrierPayAmount], [CarrierDriverName], [CarrierDriverCell], [CommodityType], [LoadType], [Tarp], [Weight], [StatusType], [CitationContact], [OrderNumber], [OrderDate], [a1ActivityType], [a1LocationCompanyID], [a1Address1], [a1Address2], [a1City], [a1State], [a1PostalCode], [a1Notes], [a1CompletionDate], [a1Status], [a1ActivityDate], [a1CommodityType], [a1Phone], [a2ActivityType], [a2LocationCompanyID], [a2Address1], [a2Address2], [a2City], [a2State], [a2PostalCode], [a2Notes], [a2CompletionDate], [a2Status], [a2ActivityDate], [a2CommodityType], [a2Phone], [a3ActivityType], [a3LocationCompanyID], [a3Address1], [a3Address2], [a3City], [a3State], [a3PostalCode], [a3Notes], [a3CompletionDate], [a3Status], [a3ActivityDate], [a3CommodityType], [a3Phone], [a4ActivityType], [a4LocationCompanyID], [a4Address1], [a4Address2], [a4City], [a4State], [a4PostalCode], [a4Notes], [a4CompletionDate], [a4Status], [a4ActivityDate], [a4CommodityType], [a4Phone], a1Contact, a2Contact, a3Contact, a4Contact, a1ActivityTime, a2ActivityTime, a3ActivityTime, a4ActivityTime, ExtraCharge1Amount, ExtraCharge1Description, ExtraPay1Amount, ExtraPay1Description, a1ActivityTimeEnd ,a2ActivityTimeEnd ,a3ActivityTimeEnd,a4ActivityTimeEnd, CustomerContact) VALUES (@CustomerCompanyID, @CarrierCompanyID, @CarrierContact, @CarrierPhone, @CarrierFax, @CarrierEmail, @Notes, @CustomerPONumber, @CustomerBillAmount, @CarrierPayAmount, @CarrierDriverName, @CarrierDriverCell, @CommodityType, @LoadType, @Tarp, @Weight, @StatusType, @CitationContact, @OrderNumber, @OrderDate, @a1ActivityType, @a1LocationCompanyID, @a1Address1, @a1Address2, @a1City, @a1State, @a1PostalCode, @a1Notes, @a1CompletionDate, @a1Status, @a1ActivityDate, @a1CommodityType, @a1Phone, @a2ActivityType, @a2LocationCompanyID, @a2Address1, @a2Address2, @a2City, @a2State, @a2PostalCode, @a2Notes, @a2CompletionDate, @a2Status, @a2ActivityDate, @a2CommodityType, @a2Phone, @a3ActivityType, @a3LocationCompanyID, @a3Address1, @a3Address2, @a3City, @a3State, @a3PostalCode, @a3Notes, @a3CompletionDate, @a3Status, @a3ActivityDate, @a3CommodityType, @a3Phone, @a4ActivityType, @a4LocationCompanyID, @a4Address1, @a4Address2, @a4City, @a4State, @a4PostalCode, @a4Notes, @a4CompletionDate, @a4Status, @a4ActivityDate, @a4CommodityType, @a4Phone, @a1Contact, @a2Contact, @a3Contact, @a4Contact, @a1ActivityTime, @a2ActivityTime, @a3ActivityTime, @a4ActivityTime, @ExtraCharge1Amount, @ExtraCharge1Description, @ExtraPay1Amount, @ExtraPay1Description, a1ActivityTimeEnd ,a2ActivityTimeEnd ,a3ActivityTimeEnd,a4ActivityTimeEnd, CustomerContact)" 
        SelectCommand="SELECT * FROM [ShippingOrder] WHERE ([ShippingOrderID] = @ShippingOrderID)" 
        UpdateCommand="UPDATE [ShippingOrder] SET [CustomerCompanyID] = @CustomerCompanyID, [CarrierCompanyID] = @CarrierCompanyID, [CarrierContact] = @CarrierContact, [CarrierPhone] = @CarrierPhone, [CarrierFax] = @CarrierFax, [CarrierEmail] = @CarrierEmail, [Notes] = @Notes, [CustomerPONumber] = @CustomerPONumber, [CustomerBillAmount] = @CustomerBillAmount, [CarrierPayAmount] = @CarrierPayAmount, [CarrierDriverName] = @CarrierDriverName, [CarrierDriverCell] = @CarrierDriverCell, [CommodityType] = @CommodityType, [LoadType] = @LoadType, [Tarp] = @Tarp, [Weight] = @Weight, [StatusType] = @StatusType, [CitationContact] = @CitationContact, [OrderNumber] = @OrderNumber, [OrderDate] = @OrderDate, [a1ActivityType] = @a1ActivityType, [a1LocationCompanyID] = @a1LocationCompanyID, [a1Address1] = @a1Address1, [a1Address2] = @a1Address2, [a1City] = @a1City, [a1State] = @a1State, [a1PostalCode] = @a1PostalCode, [a1Notes] = @a1Notes, [a1CompletionDate] = @a1CompletionDate, [a1Status] = @a1Status, [a1ActivityDate] = @a1ActivityDate, [a1CommodityType] = @a1CommodityType, [a1Phone] = @a1Phone, [a2ActivityType] = @a2ActivityType, [a2LocationCompanyID] = @a2LocationCompanyID, [a2Address1] = @a2Address1, [a2Address2] = @a2Address2, [a2City] = @a2City, [a2State] = @a2State, [a2PostalCode] = @a2PostalCode, [a2Notes] = @a2Notes, [a2CompletionDate] = @a2CompletionDate, [a2Status] = @a2Status, [a2ActivityDate] = @a2ActivityDate, [a2CommodityType] = @a2CommodityType, [a2Phone] = @a2Phone, [a3ActivityType] = @a3ActivityType, [a3LocationCompanyID] = @a3LocationCompanyID, [a3Address1] = @a3Address1, [a3Address2] = @a3Address2, [a3City] = @a3City, [a3State] = @a3State, [a3PostalCode] = @a3PostalCode, [a3Notes] = @a3Notes, [a3CompletionDate] = @a3CompletionDate, [a3Status] = @a3Status, [a3ActivityDate] = @a3ActivityDate, [a3CommodityType] = @a3CommodityType, [a3Phone] = @a3Phone, [a4ActivityType] = @a4ActivityType, [a4LocationCompanyID] = @a4LocationCompanyID, [a4Address1] = @a4Address1, [a4Address2] = @a4Address2, [a4City] = @a4City, [a4State] = @a4State, [a4PostalCode] = @a4PostalCode, [a4Notes] = @a4Notes, [a4CompletionDate] = @a4CompletionDate, [a4Status] = @a4Status, [a4ActivityDate] = @a4ActivityDate, [a4CommodityType] = @a4CommodityType, [a4Phone] = @a4Phone, a1contact = @a1Contact, a2Contact = @a2Contact, a3Contact = @a3Contact, a4Contact = @a4Contact, a1ActivityTime = @a1ActivityTime, a2ActivityTime = @a2ActivityTime, a3ActivityTime = @a3ActivityTime, a4ActivityTime = @a4ActivityTime, ExtraCharge1Amount = @ExtraCharge1Amount, ExtraCharge1Description = @ExtraCharge1Description, ExtraPay1Amount = @ExtraPay1Amount, ExtraPay1Description = @ExtraPay1Description,[a1ActivityTimeEnd] = @a1ActivityTimeEnd,[a2ActivityTimeEnd] = @a2ActivityTimeEnd, [a3ActivityTimeEnd] = @a3ActivityTimeEnd,[a4ActivityTimeEnd] = @a4ActivityTimeEnd,[CustomerContact] = @CustomerContact WHERE [ShippingOrderID] = @ShippingOrderID">
        <DeleteParameters>
            <asp:Parameter Name="ShippingOrderID"  />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerCompanyID"  />
            <asp:Parameter Name="CarrierCompanyID"  />
            <asp:Parameter Name="CarrierContact" Type="String" />
            <asp:Parameter Name="CarrierPhone" Type="String" />
            <asp:Parameter Name="CarrierFax" Type="String" />
            <asp:Parameter Name="CarrierEmail" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="CustomerPONumber" Type="String" />
            <asp:Parameter Name="CustomerBillAmount"  />
            <asp:Parameter Name="CarrierPayAmount"  />
            <asp:Parameter Name="CarrierDriverName" Type="String" />
            <asp:Parameter Name="CarrierDriverCell" Type="String" />
            <asp:Parameter Name="CommodityType" Type="String" />
            <asp:Parameter Name="LoadType" Type="String" />
            <asp:Parameter Name="Tarp" Type="String" />
            <asp:Parameter Name="Weight" Type="String" />
            <asp:Parameter Name="StatusType" Type="String" />
            <asp:Parameter Name="CitationContact" Type="String" />
            <asp:Parameter Name="OrderNumber"  />
            <asp:Parameter DbType="Date" Name="OrderDate" />
            <asp:Parameter Name="a1ActivityType" Type="String" />
            <asp:Parameter Name="a1LocationCompanyID"  />
            <asp:Parameter Name="a1Address1" Type="String" />
            <asp:Parameter Name="a1Address2" Type="String" />
            <asp:Parameter Name="a1City" Type="String" />
            <asp:Parameter Name="a1State" Type="String" />
            <asp:Parameter Name="a1PostalCode" Type="String" />
            <asp:Parameter Name="a1Notes" Type="String" />
            <asp:Parameter Name="a1CompletionDate"  />
            <asp:Parameter Name="a1Status" Type="String" />
            <asp:Parameter Name="a1ActivityDate" Type="String" />
            <asp:Parameter Name="a1CommodityType" Type="String" />
            <asp:Parameter Name="a1Phone" Type="String" />
            <asp:Parameter Name="a2ActivityType" Type="String" />
            <asp:Parameter Name="a2LocationCompanyID"  />
            <asp:Parameter Name="a2Address1" Type="String" />
            <asp:Parameter Name="a2Address2" Type="String" />
            <asp:Parameter Name="a2City" Type="String" />
            <asp:Parameter Name="a2State" Type="String" />
            <asp:Parameter Name="a2PostalCode" Type="String" />
            <asp:Parameter Name="a2Notes" Type="String" />
            <asp:Parameter Name="a2CompletionDate"  />
            <asp:Parameter Name="a2Status" Type="String" />
            <asp:Parameter Name="a2ActivityDate" Type="String" />
            <asp:Parameter Name="a2CommodityType" Type="String" />
            <asp:Parameter Name="a2Phone" Type="String" />
            <asp:Parameter Name="a3ActivityType" Type="String" />
            <asp:Parameter Name="a3LocationCompanyID"  />
            <asp:Parameter Name="a3Address1" Type="String" />
            <asp:Parameter Name="a3Address2" Type="String" />
            <asp:Parameter Name="a3City" Type="String" />
            <asp:Parameter Name="a3State" Type="String" />
            <asp:Parameter Name="a3PostalCode" Type="String" />
            <asp:Parameter Name="a3Notes" Type="String" />
            <asp:Parameter Name="a3CompletionDate"  />
            <asp:Parameter Name="a3Status" Type="String" />
            <asp:Parameter Name="a3ActivityDate" Type="String" />
            <asp:Parameter Name="a3CommodityType" Type="String" />
            <asp:Parameter Name="a3Phone" Type="String" />
            <asp:Parameter Name="a4ActivityType" Type="String" />
            <asp:Parameter Name="a4LocationCompanyID"  />
            <asp:Parameter Name="a4Address1" Type="String" />
            <asp:Parameter Name="a4Address2" Type="String" />
            <asp:Parameter Name="a4City" Type="String" />
            <asp:Parameter Name="a4State" Type="String" />
            <asp:Parameter Name="a4PostalCode" Type="String" />
            <asp:Parameter Name="a4Notes" Type="String" />
            <asp:Parameter Name="a4CompletionDate"  />
            <asp:Parameter Name="a4Status" Type="String" />
            <asp:Parameter Name="a4ActivityDate" Type="String" />
            <asp:Parameter Name="a4CommodityType" Type="String" />
            <asp:Parameter Name="a4Phone" Type="String" />
            <asp:Parameter Name="a1Contact" Type="String" />
            <asp:Parameter Name="a2Contact" Type="String" />
            <asp:Parameter Name="a3Contact" Type="String" />
            <asp:Parameter Name="a4Contact" Type="String" />
                        <asp:Parameter Name="a1ActivityTime" Type="String" />
            <asp:Parameter Name="a2ActivityTime" Type="String" />
            <asp:Parameter Name="a3ActivityTime" Type="String" />
            <asp:Parameter Name="a4ActivityTime" Type="String" />
            <asp:Parameter Name="ExtraCharge1Amount" Type="String" />
            <asp:Parameter Name="ExtraCharge1Description" Type="String" />
            <asp:Parameter Name="ExtraPay1Amount" Type="String" />
            <asp:Parameter Name="ExtraPay1Description" Type="String" />

        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="ShippingOrderID" QueryStringField="id"  />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustomerCompanyID"  />
            <asp:Parameter Name="CarrierCompanyID"  />
            <asp:Parameter Name="CarrierContact" Type="String" />
            <asp:Parameter Name="CarrierPhone" Type="String" />
            <asp:Parameter Name="CarrierFax" Type="String" />
            <asp:Parameter Name="CarrierEmail" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="CustomerPONumber" Type="String" />
            <asp:Parameter Name="CustomerBillAmount"  />
            <asp:Parameter Name="CarrierPayAmount"  />
            <asp:Parameter Name="CarrierDriverName" Type="String" />
            <asp:Parameter Name="CarrierDriverCell" Type="String" />
            <asp:Parameter Name="CommodityType" Type="String" />
            <asp:Parameter Name="LoadType" Type="String" />
            <asp:Parameter Name="Tarp" Type="String" />
            <asp:Parameter Name="Weight" Type="String" />
            <asp:Parameter Name="StatusType" Type="String" />
            <asp:Parameter Name="CitationContact" Type="String" />
            <asp:Parameter Name="OrderNumber"  />
            <asp:Parameter DbType="Date" Name="OrderDate" />
            <asp:Parameter Name="a1ActivityType" Type="String" />
            <asp:Parameter Name="a1LocationCompanyID"  />
            <asp:Parameter Name="a1Address1" Type="String" />
            <asp:Parameter Name="a1Address2" Type="String" />
            <asp:Parameter Name="a1City" Type="String" />
            <asp:Parameter Name="a1State" Type="String" />
            <asp:Parameter Name="a1PostalCode" Type="String" />
            <asp:Parameter Name="a1Notes" Type="String" />
            <asp:Parameter Name="a1CompletionDate"  />
            <asp:Parameter Name="a1Status" Type="String" />
            <asp:Parameter Name="a1ActivityDate" Type="String" />
            <asp:Parameter Name="a1CommodityType" Type="String" />
            <asp:Parameter Name="a1Phone" Type="String" />
            <asp:Parameter Name="a2ActivityType" Type="String" />
            <asp:Parameter Name="a2LocationCompanyID"  />
            <asp:Parameter Name="a2Address1" Type="String" />
            <asp:Parameter Name="a2Address2" Type="String" />
            <asp:Parameter Name="a2City" Type="String" />
            <asp:Parameter Name="a2State" Type="String" />
            <asp:Parameter Name="a2PostalCode" Type="String" />
            <asp:Parameter Name="a2Notes" Type="String" />
            <asp:Parameter Name="a2CompletionDate"  />
            <asp:Parameter Name="a2Status" Type="String" />
            <asp:Parameter Name="a2ActivityDate" Type="String" />
            <asp:Parameter Name="a2CommodityType" Type="String" />
            <asp:Parameter Name="a2Phone" Type="String" />
            <asp:Parameter Name="a3ActivityType" Type="String" />
            <asp:Parameter Name="a3LocationCompanyID"  />
            <asp:Parameter Name="a3Address1" Type="String" />
            <asp:Parameter Name="a3Address2" Type="String" />
            <asp:Parameter Name="a3City" Type="String" />
            <asp:Parameter Name="a3State" Type="String" />
            <asp:Parameter Name="a3PostalCode" Type="String" />
            <asp:Parameter Name="a3Notes" Type="String" />
            <asp:Parameter Name="a3CompletionDate"  />
            <asp:Parameter Name="a3Status" Type="String" />
            <asp:Parameter Name="a3ActivityDate" Type="String" />
            <asp:Parameter Name="a3CommodityType" Type="String" />
            <asp:Parameter Name="a3Phone" Type="String" />
            <asp:Parameter Name="a4ActivityType" Type="String" />
            <asp:Parameter Name="a4LocationCompanyID"  />
            <asp:Parameter Name="a4Address1" Type="String" />
            <asp:Parameter Name="a4Address2" Type="String" />
            <asp:Parameter Name="a4City" Type="String" />
            <asp:Parameter Name="a4State" Type="String" />
            <asp:Parameter Name="a4PostalCode" Type="String" />
            <asp:Parameter Name="a4Notes" Type="String" />
            <asp:Parameter Name="a4CompletionDate"  />
            <asp:Parameter Name="a4Status" Type="String" />
            <asp:Parameter Name="a4ActivityDate" Type="String" />
            <asp:Parameter Name="a4CommodityType" Type="String" />
            <asp:Parameter Name="a4Phone" Type="String" />
            <asp:Parameter Name="ShippingOrderID"  />
            <asp:Parameter Name="a1Contact" Type="String" />
            <asp:Parameter Name="a2Contact" Type="String" />
            <asp:Parameter Name="a3Contact" Type="String" />
            <asp:Parameter Name="a4Contact" Type="String" />
            <asp:Parameter Name="a1ActivityTime" Type="String" />
            <asp:Parameter Name="a2ActivityTime" Type="String" />
            <asp:Parameter Name="a3ActivityTime" Type="String" />
            <asp:Parameter Name="a4ActivityTime" Type="String" />
            <asp:Parameter Name="ExtraCharge1Amount" Type="String" />
            <asp:Parameter Name="ExtraCharge1Description" Type="String" />
            <asp:Parameter Name="ExtraPay1Amount" Type="String" />
            <asp:Parameter Name="ExtraPay1Description" Type="String" />

        </UpdateParameters>
    </asp:SqlDataSource>--%>
    <asp:Button ID="SaveButton" runat="server" Text="Save" TabIndex="501" />
    <asp:Button ID="CancelButton" runat="server" Text="Cancel" CausesValidation="False" TabIndex="501" />
</asp:Content>
