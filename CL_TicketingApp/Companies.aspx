<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Companies.aspx.vb" Inherits="CL_TicketingApp.Companies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Companies</h1>
        Search for
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;in
    <asp:DropDownList ID="CompanyTypeDropDownList" runat="server">
        <asp:ListItem>Customers</asp:ListItem>
        <asp:ListItem Selected="True">Vendors</asp:ListItem>
        <asp:ListItem>Pick/Drop Locations</asp:ListItem>
    </asp:DropDownList>&nbsp;Show Disabled Items <asp:CheckBox ID="ShowDisabledItemsCheckBox" runat="server" Checked="false" />
&nbsp;<asp:Button ID="SearchButton" runat="server" Text="Search" />&nbsp;<asp:Button id="NewCustomerButton" runat="server" Text="New Customer"/>
    &nbsp;<asp:Button id="NewVendorButton" runat="server" Text="New Vendor"/>
    &nbsp;<asp:Button id="NewLocationButton" runat="server" Text="New Pick/Drop Location"/>&nbsp;<asp:Button id="PurgeButton" runat="server" Text="Purge" OnClientClick="return confirm('Are you sure you want disable locations with no activity in the past 365 days?');" />
    <br />
    <br />
    <asp:GridView AllowSorting="true" EnableViewState="false" ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="Id" DataSourceID="CompanyDataSource" ForeColor="Black" GridLines="Vertical" Width="100%" AllowPaging ="true" PageSize="50">
        <AlternatingRowStyle BackColor="#CCCCCC" />
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="#" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
            <asp:TemplateField HeaderText="Name" SortExpression="CompanyName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CompanyName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CompanyName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Contact" SortExpression="Contact">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Contact") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Contact") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Phone" SortExpression="Phone">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Phone") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Phone") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fax" SortExpression="Fax">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Fax") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Fax") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="email" SortExpression="email">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Shipping" SortExpression="sCity">
                <EditItemTemplate>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="sCityLabel" runat="server" Text='<%# Bind("sCity") %>'></asp:Label>, <asp:Label ID="sStateLabel" runat="server" Text='<%# Bind("sState") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Billing" SortExpression="bCity">
                <EditItemTemplate>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="bCityLabel" runat="server" Text='<%# Bind("bCity") %>'></asp:Label>, <asp:Label ID="bStateLabel" runat="server" Text='<%# Bind("bState") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>


            <asp:TemplateField HeaderText="MCNumber" SortExpression="MCNumber">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("MCNumber") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("MCNumber") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CheckBoxField DataField="Disabled" HeaderText="Disabled" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="EditButton" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="GoToEditor" Text="Edit" />
                    <asp:Button CssClass="btn btn-sm btn-info" ID="ScanDocButton" CommandArgument='<%# Eval("Id") %>' runat="server" Text="Scan" OnClick="ScanDocButton_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#CCCCCC" />
        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="Gray" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
    </asp:GridView>
        <br />

<asp:SqlDataSource ID="CompanyDataSource" runat="server" ConflictDetection="CompareAllValues" 
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
    DeleteCommand="DELETE FROM [Company] WHERE [Id] = @original_Id AND (([CompanyName] = @original_CompanyName) OR ([CompanyName] IS NULL AND @original_CompanyName IS NULL)) AND (([Contact] = @original_Contact) OR ([Contact] IS NULL AND @original_Contact IS NULL)) AND (([Phone] = @original_Phone) OR ([Phone] IS NULL AND @original_Phone IS NULL)) AND (([Fax] = @original_Fax) OR ([Fax] IS NULL AND @original_Fax IS NULL)) AND (([email] = @original_email) OR ([email] IS NULL AND @original_email IS NULL)) AND (([bAddress1] = @original_bAddress1) OR ([bAddress1] IS NULL AND @original_bAddress1 IS NULL)) AND (([bAddress2] = @original_bAddress2) OR ([bAddress2] IS NULL AND @original_bAddress2 IS NULL)) AND (([bCity] = @original_bCity) OR ([bCity] IS NULL AND @original_bCity IS NULL)) AND (([bState] = @original_bState) OR ([bState] IS NULL AND @original_bState IS NULL)) AND (([bPostalCode] = @original_bPostalCode) OR ([bPostalCode] IS NULL AND @original_bPostalCode IS NULL)) AND (([sAddress1] = @original_sAddress1) OR ([sAddress1] IS NULL AND @original_sAddress1 IS NULL)) AND (([sAddress2] = @original_sAddress2) OR ([sAddress2] IS NULL AND @original_sAddress2 IS NULL)) AND (([sCity] = @original_sCity) OR ([sCity] IS NULL AND @original_sCity IS NULL)) AND (([sState] = @original_sState) OR ([sState] IS NULL AND @original_sState IS NULL)) AND (([sPostalCode] = @original_sPostalCode) OR ([sPostalCode] IS NULL AND @original_sPostalCode IS NULL)) AND (([Notes] = @original_Notes) OR ([Notes] IS NULL AND @original_Notes IS NULL)) AND (([Vendor] = @original_Vendor) OR ([Vendor] IS NULL AND @original_Vendor IS NULL)) AND (([Customer] = @original_Customer) OR ([Customer] IS NULL AND @original_Customer IS NULL))" InsertCommand="INSERT INTO [Company] ([CompanyName], [Contact], [Phone], [Fax], [email], [bAddress1], [bAddress2], [bCity], [bState], [bPostalCode], [sAddress1], [sAddress2], [sCity], [sState], [sPostalCode], [Notes], [Vendor], [Customer], Disabled) VALUES (@CompanyName, @Contact, @Phone, @Fax, @email, @bAddress1, @bAddress2, @bCity, @bState, @bPostalCode, @sAddress1, @sAddress2, @sCity, @sState, @sPostalCode, @Notes, @Vendor, @Customer, @Disabled)" OldValuesParameterFormatString="original_{0}" 
    SelectCommand="SELECT Id, CompanyName, Contact, Phone, Fax, email, bAddress1, bAddress2, bCity, bState, bPostalCode, sAddress1, sAddress2, sCity, sState, sPostalCode, Notes, Vendor, Customer, CargoInsuranceEffectiveDate, CargoInsuranceExpirationDate, LiabilityInsuranceEffectiveDate, LiabilityInsuranceExpirationDate, MCNumber, Disabled FROM Company WHERE (CompanyName LIKE @Filter) AND ((ISNULL(Vendor, 0) = @Vendor ) and (isnull(disabled,0) = 0 or @Disabled = 1) and (ISNULL(Customer, 0) = @Customer))" 
    UpdateCommand="UPDATE [Company] SET [CompanyName] = @CompanyName, [Contact] = @Contact, [Phone] = @Phone, [Fax] = @Fax, [email] = @email, [bAddress1] = @bAddress1, [bAddress2] = @bAddress2, [bCity] = @bCity, [bState] = @bState, [bPostalCode] = @bPostalCode, [sAddress1] = @sAddress1, [sAddress2] = @sAddress2, [sCity] = @sCity, [sState] = @sState, [sPostalCode] = @sPostalCode, [Notes] = @Notes, [Vendor] = @Vendor, [Customer] = @Customer, Disabled = @Disabled WHERE [Id] = @original_Id AND (([CompanyName] = @original_CompanyName) OR ([CompanyName] IS NULL AND @original_CompanyName IS NULL)) AND (([Contact] = @original_Contact) OR ([Contact] IS NULL AND @original_Contact IS NULL)) AND (([Phone] = @original_Phone) OR ([Phone] IS NULL AND @original_Phone IS NULL)) AND (([Fax] = @original_Fax) OR ([Fax] IS NULL AND @original_Fax IS NULL)) AND (([email] = @original_email) OR ([email] IS NULL AND @original_email IS NULL)) AND (([bAddress1] = @original_bAddress1) OR ([bAddress1] IS NULL AND @original_bAddress1 IS NULL)) AND (([bAddress2] = @original_bAddress2) OR ([bAddress2] IS NULL AND @original_bAddress2 IS NULL)) AND (([bCity] = @original_bCity) OR ([bCity] IS NULL AND @original_bCity IS NULL)) AND (([bState] = @original_bState) OR ([bState] IS NULL AND @original_bState IS NULL)) AND (([bPostalCode] = @original_bPostalCode) OR ([bPostalCode] IS NULL AND @original_bPostalCode IS NULL)) AND (([sAddress1] = @original_sAddress1) OR ([sAddress1] IS NULL AND @original_sAddress1 IS NULL)) AND (([sAddress2] = @original_sAddress2) OR ([sAddress2] IS NULL AND @original_sAddress2 IS NULL)) AND (([sCity] = @original_sCity) OR ([sCity] IS NULL AND @original_sCity IS NULL)) AND (([sState] = @original_sState) OR ([sState] IS NULL AND @original_sState IS NULL)) AND (([sPostalCode] = @original_sPostalCode) OR ([sPostalCode] IS NULL AND @original_sPostalCode IS NULL)) AND (([Notes] = @original_Notes) OR ([Notes] IS NULL AND @original_Notes IS NULL)) AND (([Vendor] = @original_Vendor) OR ([Vendor] IS NULL AND @original_Vendor IS NULL)) AND (([Customer] = @original_Customer) OR ([Customer] IS NULL AND @original_Customer IS NULL))">
    <DeleteParameters>
        <asp:Parameter Name="original_Id" Type="Int32" />
        <asp:Parameter Name="original_CompanyName" Type="String" />
        <asp:Parameter Name="original_Contact" Type="String" />
        <asp:Parameter Name="original_Phone" Type="String" />
        <asp:Parameter Name="original_Fax" Type="String" />
        <asp:Parameter Name="original_email" Type="String" />
        <asp:Parameter Name="original_bAddress1" Type="String" />
        <asp:Parameter Name="original_bAddress2" Type="String" />
        <asp:Parameter Name="original_bCity" Type="String" />
        <asp:Parameter Name="original_bState" Type="String" />
        <asp:Parameter Name="original_bPostalCode" Type="String" />
        <asp:Parameter Name="original_sAddress1" Type="String" />
        <asp:Parameter Name="original_sAddress2" Type="String" />
        <asp:Parameter Name="original_sCity" Type="String" />
        <asp:Parameter Name="original_sState" Type="String" />
        <asp:Parameter Name="original_sPostalCode" Type="String" />
        <asp:Parameter Name="original_Notes" Type="String" />
        <asp:Parameter Name="original_Vendor" Type="Boolean" />
        <asp:Parameter Name="original_Customer" Type="Boolean" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="CompanyName" Type="String" />
        <asp:Parameter Name="Contact" Type="String" />
        <asp:Parameter Name="Phone" Type="String" />
        <asp:Parameter Name="Fax" Type="String" />
        <asp:Parameter Name="email" Type="String" />
        <asp:Parameter Name="bAddress1" Type="String" />
        <asp:Parameter Name="bAddress2" Type="String" />
        <asp:Parameter Name="bCity" Type="String" />
        <asp:Parameter Name="bState" Type="String" />
        <asp:Parameter Name="bPostalCode" Type="String" />
        <asp:Parameter Name="sAddress1" Type="String" />
        <asp:Parameter Name="sAddress2" Type="String" />
        <asp:Parameter Name="sCity" Type="String" />
        <asp:Parameter Name="sState" Type="String" />
        <asp:Parameter Name="sPostalCode" Type="String" />
        <asp:Parameter Name="Notes" Type="String" />
        <asp:Parameter Name="Vendor" Type="Boolean" />
        <asp:Parameter Name="Customer" Type="Boolean" />
        <asp:Parameter Name="Disabled" Type="Boolean" />
    </InsertParameters>
    <SelectParameters>
        <asp:Parameter Name="Filter" />
        <asp:Parameter Name="Vendor" />
        <asp:Parameter Name="Customer" />
        <asp:ControlParameter Name="Disabled" ControlID="ShowDisabledItemsCheckBox" PropertyName="Checked" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="CompanyName" Type="String" />
        <asp:Parameter Name="Contact" Type="String" />
        <asp:Parameter Name="Phone" Type="String" />
        <asp:Parameter Name="Fax" Type="String" />
        <asp:Parameter Name="email" Type="String" />
        <asp:Parameter Name="bAddress1" Type="String" />
        <asp:Parameter Name="bAddress2" Type="String" />
        <asp:Parameter Name="bCity" Type="String" />
        <asp:Parameter Name="bState" Type="String" />
        <asp:Parameter Name="bPostalCode" Type="String" />
        <asp:Parameter Name="sAddress1" Type="String" />
        <asp:Parameter Name="sAddress2" Type="String" />
        <asp:Parameter Name="sCity" Type="String" />
        <asp:Parameter Name="sState" Type="String" />
        <asp:Parameter Name="sPostalCode" Type="String" />
        <asp:Parameter Name="Notes" Type="String" />
        <asp:Parameter Name="Vendor" Type="Boolean" />
        <asp:Parameter Name="Customer" Type="Boolean" />
        <asp:Parameter Name="Disabled" Type="Boolean" />
        <asp:Parameter Name="original_Id" Type="Int32" />
        <asp:Parameter Name="original_CompanyName" Type="String" />
        <asp:Parameter Name="original_Contact" Type="String" />
        <asp:Parameter Name="original_Phone" Type="String" />
        <asp:Parameter Name="original_Fax" Type="String" />
        <asp:Parameter Name="original_email" Type="String" />
        <asp:Parameter Name="original_bAddress1" Type="String" />
        <asp:Parameter Name="original_bAddress2" Type="String" />
        <asp:Parameter Name="original_bCity" Type="String" />
        <asp:Parameter Name="original_bState" Type="String" />
        <asp:Parameter Name="original_bPostalCode" Type="String" />
        <asp:Parameter Name="original_sAddress1" Type="String" />
        <asp:Parameter Name="original_sAddress2" Type="String" />
        <asp:Parameter Name="original_sCity" Type="String" />
        <asp:Parameter Name="original_sState" Type="String" />
        <asp:Parameter Name="original_sPostalCode" Type="String" />
        <asp:Parameter Name="original_Notes" Type="String" />
        <asp:Parameter Name="original_Vendor" Type="Boolean" />
        <asp:Parameter Name="original_Customer" Type="Boolean" />
    </UpdateParameters>
</asp:SqlDataSource>
</asp:Content>
