<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CompanyPopupEditorWebUserControl.ascx.vb" Inherits="CL_TicketingApp.CompanyPopupEditorWebUserControl" %>
 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<style type="text/css">
    .modalBackground
    {
        background-color: Black;
        filter: alpha(opacity=90);
        opacity: 0.8;
    }
    .modalPopup
    {
        background-color: #FFFFFF;
        border-width: 3px;
        border-style: solid;
        border-color: black;
        padding-top: 10px;
        padding-left: 10px;
        width: 700px;
        height: 700px;
    }
</style>



<%--<asp:ImageButton ID="NewCarrierImageButton" runat="server" AlternateText="New Carrier" ImageUrl="~/Images/plus1.gif" />

<cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel1" TargetControlID="NewCarrierImageButton"
    CancelControlID="btnClose" BackgroundCssClass="modalBackground">
</cc1:ModalPopupExtender>


<asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" style="display:none">
    
    <asp:UpdatePanel ID="CompanyUpdatePanel" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
    <ContentTemplate>
    --%>
    
<asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="CompanyDataSource" DefaultMode="Insert">
        <EditItemTemplate>
             <table>
            <tr><td>Company (<asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />):
            </td><td><asp:TextBox ID="CompanyNameTextBox" runat="server" Text='<%# Bind("CompanyName") %>' />
            </td></tr>
            <tr><td>Contact:
            </td><td><asp:TextBox ID="ContactTextBox" runat="server" Text='<%# Bind("Contact") %>' />
            </td></tr>
            <tr><td>Phone:
            </td><td><asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' />
            </td></tr>
            <tr><td>Fax:
            </td><td><asp:TextBox ID="FaxTextBox" runat="server" Text='<%# Bind("Fax") %>' />
            </td></tr>
            <tr><td>email:
            </td><td><asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' />
            </td></tr>
            <tr><td>bAddress1:
            </td><td><asp:TextBox ID="bAddress1TextBox" runat="server" Text='<%# Bind("bAddress1") %>' />
            </td></tr>
            <tr><td>bAddress2:
            </td><td><asp:TextBox ID="bAddress2TextBox" runat="server" Text='<%# Bind("bAddress2") %>' />
            </td></tr>
            <tr><td>bCity:
            </td><td><asp:TextBox ID="bCityTextBox" runat="server" Text='<%# Bind("bCity") %>' />&nbsp;<asp:TextBox ID="bStateTextBox" runat="server" Text='<%# Bind("bState") %>' Width="30px"/>&nbsp;<asp:TextBox ID="bPostalCodeTextBox" runat="server" Text='<%# Bind("bPostalCode") %>' />
            </td></tr>
            
            <tr><td>sAddress1:
            </td><td><asp:TextBox ID="sAddress1TextBox" runat="server" Text='<%# Bind("sAddress1") %>' />
            </td></tr>
            <tr><td>sAddress2:
            </td><td><asp:TextBox ID="sAddress2TextBox" runat="server" Text='<%# Bind("sAddress2") %>' />
            </td></tr>
            <tr><td>City/State/Zip:
            </td><td><asp:TextBox ID="sCityTextBox" runat="server" Text='<%# Bind("sCity") %>' />&nbsp;<asp:TextBox ID="sStateTextBox" runat="server" Text='<%# Bind("sState") %>' Width="30px" />&nbsp;<asp:TextBox ID="sPostalCodeTextBox" runat="server" Text='<%# Bind("sPostalCode") %>' />
            </td></tr>
           
            <tr><td>Notes:
            </td><td><asp:TextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes") %>' />
            </td></tr>
            
                 <tr><td>Cargo Insurance Effective Date:
            </td><td><asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CargoInsuranceEffectiveDate") %>' />
            </td></tr>
            
                 <tr><td>Cargo Insurance Expiration Date:
            </td><td><asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CargoInsuranceExpirationDate") %>' />
            </td></tr>                 
                 
                                  <tr><td>Liability Insurance Effective Date:
            </td><td><asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("LiabilityInsuranceEffectiveDate") %>' />
            </td></tr>
                 
                                  <tr><td>Liability Insurance Expiration Date:
            </td><td><asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("LiabilityInsuranceExpirationDate") %>' />
            </td></tr>
                                  <tr><td>MC Number:
            </td><td><asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("MCNumber") %>' />
            </td></tr>
                 <tr><td>Type:
            </td><td><asp:CheckBox ID="VendorCheckBox" runat="server" Checked='<%# Bind("Vendor") %>' Text="Vendor" />&nbsp;<asp:CheckBox ID="CustomerCheckBox" runat="server" Checked='<%# Bind("Customer") %>' Text="Customer" />
            </td></tr>
            <tr><td></td><td>
              <%-- <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
               
                 </td></tr></table>





            
        </EditItemTemplate>
        <InsertItemTemplate>
            <table>
            <tr><td>Company:
            </td><td><asp:TextBox ID="CompanyNameTextBox" runat="server" Text='<%# Bind("CompanyName") %>' />
            </td></tr>
            <tr><td>Contact:
            </td><td><asp:TextBox ID="ContactTextBox" runat="server" Text='<%# Bind("Contact") %>' />
            </td></tr>
            <tr><td>Phone:
            </td><td><asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' />
            </td></tr>
            <tr><td>Fax:
            </td><td><asp:TextBox ID="FaxTextBox" runat="server" Text='<%# Bind("Fax") %>' />
            </td></tr>
            <tr><td>email:
            </td><td><asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' />
            </td></tr>
            <tr><td>bAddress1:
            </td><td><asp:TextBox ID="bAddress1TextBox" runat="server" Text='<%# Bind("bAddress1") %>' />
            </td></tr>
            <tr><td>bAddress2:
            </td><td><asp:TextBox ID="bAddress2TextBox" runat="server" Text='<%# Bind("bAddress2") %>' />
            </td></tr>
            <tr><td>bCity:
            </td><td><asp:TextBox ID="bCityTextBox" runat="server" Text='<%# Bind("bCity") %>' />&nbsp;<asp:TextBox ID="bStateTextBox" runat="server" Text='<%# Bind("bState") %>' Width="30px"/>&nbsp;<asp:TextBox ID="bPostalCodeTextBox" runat="server" Text='<%# Bind("bPostalCode") %>' />
            </td></tr>
            
            <tr><td>sAddress1:
            </td><td><asp:TextBox ID="sAddress1TextBox" runat="server" Text='<%# Bind("sAddress1") %>' />
            </td></tr>
            <tr><td>sAddress2:
            </td><td><asp:TextBox ID="sAddress2TextBox" runat="server" Text='<%# Bind("sAddress2") %>' />
            </td></tr>
            <tr><td>City/State/Zip:
            </td><td><asp:TextBox ID="sCityTextBox" runat="server" Text='<%# Bind("sCity") %>' />&nbsp;<asp:TextBox ID="sStateTextBox" runat="server" Text='<%# Bind("sState") %>' Width="30px" />&nbsp;<asp:TextBox ID="sPostalCodeTextBox" runat="server" Text='<%# Bind("sPostalCode") %>' />
            </td></tr>
           
            <tr><td>Notes:
            </td><td><asp:TextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes") %>' />
            </td></tr>

                 <tr><td>Cargo Insurance Effective Date:
            </td><td><asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CargoInsuranceEffectiveDate") %>' />
            </td></tr>
            
                 <tr><td>Cargo Insurance Expiration Date:
            </td><td><asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CargoInsuranceExpirationDate") %>' />
            </td></tr>                 
                 
                                  <tr><td>Liability Insurance Effective Date:
            </td><td><asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("LiabilityInsuranceEffectiveDate") %>' />
            </td></tr>
                 
                                  <tr><td>Liability Insurance Expiration Date:
            </td><td><asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("LiabilityInsuranceExpirationDate") %>' />
            </td></tr>
                                  <tr><td>MC Number:
            </td><td><asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("MCNumber") %>' />
            </td></tr>


            <tr><td>Vendor:
            </td><td><asp:CheckBox ID="VendorCheckBox" runat="server" Checked='<%# Bind("Vendor") %>' Text="Vendor" /><asp:CheckBox ID="CustomerCheckBox" runat="server" Checked='<%# Bind("Customer") %>' Text="Customer" />
            </td></tr>
            <tr><td></td><td><%--<asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
                </td></tr></table>
        </InsertItemTemplate>
        <ItemTemplate>
          
            
             <table>
            <tr><td>Company (<asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />):
            </td><td><asp:TextBox ID="CompanyNameTextBox" runat="server" Text='<%# Bind("CompanyName") %>' />
            </td></tr>
            <tr><td>Contact:
            </td><td><asp:TextBox ID="ContactTextBox" runat="server" Text='<%# Bind("Contact") %>' />
            </td></tr>
            <tr><td>Phone:
            </td><td><asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' />
            </td></tr>
            <tr><td>Fax:
            </td><td><asp:TextBox ID="FaxTextBox" runat="server" Text='<%# Bind("Fax") %>' />
            </td></tr>
            <tr><td>email:
            </td><td><asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' />
            </td></tr>
            <tr><td>bAddress1:
            </td><td><asp:TextBox ID="bAddress1TextBox" runat="server" Text='<%# Bind("bAddress1") %>' />
            </td></tr>
            <tr><td>bAddress2:
            </td><td><asp:TextBox ID="bAddress2TextBox" runat="server" Text='<%# Bind("bAddress2") %>' />
            </td></tr>
            <tr><td>bCity:
            </td><td><asp:TextBox ID="bCityTextBox" runat="server" Text='<%# Bind("bCity") %>' />&nbsp;<asp:TextBox ID="bStateTextBox" runat="server" Text='<%# Bind("bState") %>' Width="30px"/>&nbsp;<asp:TextBox ID="bPostalCodeTextBox" runat="server" Text='<%# Bind("bPostalCode") %>' />
            </td></tr>
            
            <tr><td>sAddress1:
            </td><td><asp:TextBox ID="sAddress1TextBox" runat="server" Text='<%# Bind("sAddress1") %>' />
            </td></tr>
            <tr><td>sAddress2:
            </td><td><asp:TextBox ID="sAddress2TextBox" runat="server" Text='<%# Bind("sAddress2") %>' />
            </td></tr>
            <tr><td>City/State/Zip:
            </td><td><asp:TextBox ID="sCityTextBox" runat="server" Text='<%# Bind("sCity") %>' />&nbsp;<asp:TextBox ID="sStateTextBox" runat="server" Text='<%# Bind("sState") %>' Width="30px" />&nbsp;<asp:TextBox ID="sPostalCodeTextBox" runat="server" Text='<%# Bind("sPostalCode") %>' />
            </td></tr>
           
            <tr><td>Notes:
            </td><td><asp:TextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes") %>' />
            </td></tr>


                 <tr><td>Cargo Insurance Effective Date:
            </td><td><asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CargoInsuranceEffectiveDate") %>' />
            </td></tr>
            
                 <tr><td>Cargo Insurance Expiration Date:
            </td><td><asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CargoInsuranceExpirationDate") %>' />
            </td></tr>                 
                 
                                  <tr><td>Liability Insurance Effective Date:
            </td><td><asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("LiabilityInsuranceEffectiveDate") %>' />
            </td></tr>
                 
                                  <tr><td>Liability Insurance Expiration Date:
            </td><td><asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("LiabilityInsuranceExpirationDate") %>' />
            </td></tr>
                                  <tr><td>MC Number:
            </td><td><asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("MCNumber") %>' />
            </td></tr>




            <tr><td>Type:
            </td><td><asp:CheckBox ID="VendorCheckBox" runat="server" Checked='<%# Bind("Vendor") %>' Text="Vendor" />&nbsp;<asp:CheckBox ID="CustomerCheckBox" runat="server" Checked='<%# Bind("Customer") %>' Text="Customer" />
            </td></tr>
            <tr><td></td><td>
               
                <%-- <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />--%>
                 </td></tr></table>
           
        </ItemTemplate>
    </asp:FormView>

      <%--  <asp:Button ID="Button1" runat="server" Text="Close" Visible="false" />
 </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="FormView1" />
        </Triggers>
</asp:UpdatePanel>
</asp:Panel>
   --%>


<asp:SqlDataSource ID="CompanyDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
    DeleteCommand="DELETE FROM [Company] WHERE [Id] = @original_ID" 
    InsertCommand="INSERT INTO Company(CompanyName, Contact, Phone, Fax, email, bAddress1, bAddress2, bCity, bState, bPostalCode, sAddress1, sAddress2, sCity, sState, sPostalCode, Notes, Vendor, Customer, CargoInsuranceEffectiveDate, CargoInsuranceExpirationDate, LiabilityInsuranceEffectiveDate, LiabilityInsuranceExpirationDate, MCNumber) VALUES (@CompanyName, @Contact, @Phone, @Fax, @email, @bAddress1, @bAddress2, @bCity, @bState, @bPostalCode, @sAddress1, @sAddress2, @sCity, @sState, @sPostalCode, @Notes, @Vendor , @Customer, @CargoInsuranceEffectiveDate, @CargoInsuranceExpirationDate, @LiabilityInsuranceEffectiveDate, @LiabilityInsuranceExpirationDate, @MCNumber)" 
    SelectCommand="SELECT * FROM [Company]" 
    UpdateCommand="UPDATE Company SET CompanyName = @CompanyName, Contact = @Contact, Phone = @Phone, Fax = @Fax, email = @email, bAddress1 = @bAddress1, bAddress2 = @bAddress2, bCity = @bCity, bState = @bState, bPostalCode = @bPostalCode, sAddress1 = @sAddress1, sAddress2 = @sAddress2, sCity = @sCity, sState = @sState, sPostalCode = @sPostalCode, Notes = @Notes, Vendor = @Vendor , Customer = @Customer, CargoInsuranceEffectiveDate = @CargoInsuranceEffectiveDate, CargoInsuranceExpirationDate = @CargoInsuranceExpirationDate, LiabilityInsuranceEffectiveDate = @LiabilityInsuranceEffectiveDate, LiabilityInsuranceExpirationDate = @LiabilityInsuranceExpirationDate, MCNumber = @MCNumber WHERE (Id = @ID)">
    <DeleteParameters>
        <asp:Parameter Name="original_Id" Type="Int32" />
       
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
        <asp:Parameter Name="CargoInsuranceEffectiveDate" />
        <asp:Parameter Name="CargoInsuranceExpirationDate" />
        <asp:Parameter Name="LiabilityInsuranceEffectiveDate" />
        <asp:Parameter Name="LiabilityInsuranceExpirationDate" />
        <asp:Parameter Name="MCNumber" />
    </InsertParameters>
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
        <asp:Parameter Name="CargoInsuranceEffectiveDate" />
        <asp:Parameter Name="CargoInsuranceExpirationDate" />
        <asp:Parameter Name="LiabilityInsuranceEffectiveDate" />
        <asp:Parameter Name="LiabilityInsuranceExpirationDate" />
        <asp:Parameter Name="MCNumber" />
        <asp:Parameter Name="ID" />
    </UpdateParameters>
</asp:SqlDataSource>
        






