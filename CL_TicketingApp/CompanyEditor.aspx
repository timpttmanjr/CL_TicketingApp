<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="CompanyEditor.aspx.vb" Inherits="CL_TicketingApp.CompanyEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Company Editor</h1>
    <br />
<br />
    <asp:DetailsView ID="DetailsView1" DefaultMode="Insert" runat="server" Height="50px" Width="100%" AutoGenerateRows="False" DataKeyNames="Id" DataSourceID="CompanyEditorSqlDataSource">
        <FieldHeaderStyle Width="225px" />
        <Fields>
            <asp:BoundField DataField="Id" HeaderText="Company ID" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
            <asp:BoundField DataField="CompanyName" HeaderText="Company Name" SortExpression="CompanyName" />
            <asp:BoundField DataField="Contact" HeaderText="Contact" SortExpression="Contact" />
            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
            <asp:BoundField DataField="Fax" HeaderText="Fax" SortExpression="Fax" />
            <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
            <asp:BoundField DataField="bAddress1" HeaderText="Billing Address 1" SortExpression="bAddress1" />
            <asp:BoundField DataField="bAddress2" HeaderText="Billing Address 2" SortExpression="bAddress2" />
            <asp:BoundField DataField="bCity" HeaderText="Billing City" SortExpression="bCity" />
            <asp:BoundField DataField="bState" HeaderText="Billing State" SortExpression="bState" />
            <asp:BoundField DataField="bPostalCode" HeaderText="Billing Postal Code" SortExpression="bPostalCode" />
            <asp:BoundField DataField="sAddress1" HeaderText="Shipping Address 1" SortExpression="sAddress1" />
            <asp:BoundField DataField="sAddress2" HeaderText="Shipping Address 2" SortExpression="sAddress2" />
            <asp:BoundField DataField="sCity" HeaderText="Shipping City" SortExpression="sCity" />
            <asp:BoundField DataField="sState" HeaderText="Shipping State" SortExpression="sState" />
            <asp:BoundField DataField="sPostalCode" HeaderText="Shipping Postal Code" SortExpression="sPostalCode" />
            <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
            <asp:CheckBoxField DataField="Vendor" HeaderText="Vendor" SortExpression="Vendor" />
            <asp:CheckBoxField DataField="Customer" HeaderText="Customer" SortExpression="Customer" />
            <asp:BoundField DataField="CargoInsuranceEffectiveDate" HeaderText="Cargo Insurance Effective Date" SortExpression="CargoInsuranceEffectiveDate" />
            <asp:BoundField DataField="CargoInsuranceExpirationDate" HeaderText="Cargo Insurance Expiration Date" SortExpression="CargoInsuranceExpirationDate" />
            <asp:BoundField DataField="LiabilityInsuranceEffectiveDate" HeaderText="Liability Insurance Effective Date" SortExpression="LiabilityInsuranceEffectiveDate" />
            <asp:BoundField DataField="LiabilityInsuranceExpirationDate" HeaderText="Liability Insurance Expiration Date" SortExpression="LiabilityInsuranceExpirationDate" />
            <asp:BoundField DataField="MCNumber" HeaderText="MC Number" SortExpression="MCNumber" />
            <asp:CheckBoxField DataField="Disabled" HeaderText="Disabled" SortExpression="Disabled" />
            <asp:CommandField ShowEditButton="True" ShowInsertButton="True" ShowHeader="True" />
        </Fields>
        <HeaderStyle Wrap="True" />
    </asp:DetailsView>
    <asp:SqlDataSource ID="CompanyEditorSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [Company] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Company] ([CompanyName], [Contact], [Phone], [Fax], [email], [bAddress1], [bAddress2], [bCity], [bState], [bPostalCode], [sAddress1], [sAddress2], [sCity], [sState], [sPostalCode], [Notes], [Vendor], [Customer], [CargoInsuranceEffectiveDate], [CargoInsuranceExpirationDate], [LiabilityInsuranceEffectiveDate], [LiabilityInsuranceExpirationDate], [MCNumber], Disabled) VALUES (@CompanyName, @Contact, @Phone, @Fax, @email, @bAddress1, @bAddress2, @bCity, @bState, @bPostalCode, @sAddress1, @sAddress2, @sCity, @sState, @sPostalCode, @Notes, @Vendor, @Customer, @CargoInsuranceEffectiveDate, @CargoInsuranceExpirationDate, @LiabilityInsuranceEffectiveDate, @LiabilityInsuranceExpirationDate, @MCNumber, @Disabled)" SelectCommand="SELECT * FROM [Company] WHERE ([Id] = @Id)" UpdateCommand="UPDATE [Company] SET [CompanyName] = @CompanyName, [Contact] = @Contact, [Phone] = @Phone, [Fax] = @Fax, [email] = @email, [bAddress1] = @bAddress1, [bAddress2] = @bAddress2, [bCity] = @bCity, [bState] = @bState, [bPostalCode] = @bPostalCode, [sAddress1] = @sAddress1, [sAddress2] = @sAddress2, [sCity] = @sCity, [sState] = @sState, [sPostalCode] = @sPostalCode, [Notes] = @Notes, [Vendor] = @Vendor, [Customer] = @Customer, [CargoInsuranceEffectiveDate] = @CargoInsuranceEffectiveDate, [CargoInsuranceExpirationDate] = @CargoInsuranceExpirationDate, [LiabilityInsuranceEffectiveDate] = @LiabilityInsuranceEffectiveDate, [LiabilityInsuranceExpirationDate] = @LiabilityInsuranceExpirationDate, [MCNumber] = @MCNumber, Disabled = @Disabled WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
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
            <asp:Parameter DbType="Date" Name="CargoInsuranceEffectiveDate" />
            <asp:Parameter DbType="Date" Name="CargoInsuranceExpirationDate" />
            <asp:Parameter DbType="Date" Name="LiabilityInsuranceEffectiveDate" />
            <asp:Parameter DbType="Date" Name="LiabilityInsuranceExpirationDate" />
            <asp:Parameter Name="MCNumber" Type="String" />
            <asp:Parameter Name="Disabled" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="Id" QueryStringField="coid" Type="Int32" />
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
            <asp:Parameter DbType="Date" Name="CargoInsuranceEffectiveDate" />
            <asp:Parameter DbType="Date" Name="CargoInsuranceExpirationDate" />
            <asp:Parameter DbType="Date" Name="LiabilityInsuranceEffectiveDate" />
            <asp:Parameter DbType="Date" Name="LiabilityInsuranceExpirationDate" />
            <asp:Parameter Name="MCNumber" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Disabled" Type="Boolean" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:label runat="server" id="ErrorMessageLabel"></asp:label>
</asp:Content>
