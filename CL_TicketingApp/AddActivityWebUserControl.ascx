<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AddActivityWebUserControl.ascx.vb" Inherits="CL_TicketingApp.AddActivityWebUserControl" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Src="~/CompanyPopupWrapperWebUserControl.ascx" TagPrefix="uc1" TagName="CompanyPopupWrapperWebUserControl" %>

<%--<style type="text/css">
    img {
        vertical-align: middle;
    }

    img {
        max-width: 100% !important;
    }

    img {
        border: 0;
    }

    *,
    *:before,
    *:after {
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
    }

    * {
        color: #000 !important;
        text-shadow: none !important;
        background: transparent !important;
        box-shadow: none !important;
    }
</style>--%>

<%--<asp:HiddenField ID="LocationIDHiddenField" runat="server" />--%>

<%--<script type="text/javascript">
    function <%=LocationIDHiddenField.ClientID%>LocationItemSelected(sender, e) {
        $get("<%=LocationIDHiddenField.ClientID%>").value = e.get_value();
        }

</script>--%>

<script type="text/javascript">
    function <%=LocationTextBox.ClientID%>LocationItemSelected(sender, e) {
        $get("<%=LocationIDTextBox.ClientID%>").value = e.get_value();
    }


</script>


<asp:UpdatePanel ID="ActivityUpdatePanel" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
<table width="100%">
    <tr>
        <td>Pickup/Delivery</td>
        <td>
            <asp:DropDownList ID="ActivityTypeDropDownList" runat="server" TabIndex="0">
                <asp:ListItem Selected="True"></asp:ListItem>
                <asp:ListItem>Pickup</asp:ListItem>
                <asp:ListItem>Delivery</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td>Contact</td>
        <td>
            <asp:TextBox ID="ActivityContactTextBox" runat="server" TabIndex="8"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>Company/Location</td>
        <td>
            <asp:UpdateProgress id="updateProgress" runat="server" AssociatedUpdatePanelID="LocationSelectorUpdatePanel">
    <ProgressTemplate>
        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
            <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #FFFFFF; font-size: 36px; left: 40%; top: 40%;">Loading Locations...</span>
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>
            <asp:UpdatePanel ID="LocationSelectorUpdatePanel" runat="server" UpdateMode="always" ChildrenAsTriggers="true">
                <ContentTemplate>
                    <asp:TextBox ID="LocationTextBox" runat="server" Width="350px" AutoPostBack="true" TabIndex="1"></asp:TextBox><div style="display:none;" tabindex="2"><asp:TextBox ID="LocationIDTextBox" runat="server"></asp:TextBox></div>
                    <uc1:CompanyPopupWrapperWebUserControl runat="server" ID="NewLocationPopUpControl" />
                    <%--<asp:ImageButton ID="NewLocationImageButton" runat="server" AlternateText="New Location" ImageUrl="~/Images/plus1.gif" />--%>
                    <asp:Label ID="MCNumberLabel" runat="server"></asp:Label>
                    <asp:Label ID="LocationNumberLabel" runat="server"></asp:Label>
                    <cc1:autocompleteextender servicemethod="SearchLocations"
                        minimumprefixlength="2"
                        completioninterval="100" enablecaching="false" completionsetcount="10"
                        targetcontrolid="LocationTextBox"
                        id="LocationAutoCompleteExtender" runat="server" firstrowselected="false" >
                        </cc1:autocompleteextender>

                </ContentTemplate>
            </asp:UpdatePanel>







            <%--           <asp:DropDownList ID="ActivityLocationDropDownList" runat="server" DataSourceID="CompanySqlDataSource" DataTextField="CompanyName" DataValueField="id"></asp:DropDownList>\
                    <asp:ImageButton ID="NewCompanyImageButton" runat="server" AlternateText="New Company" ImageUrl="~/Images/plus1.gif" />
        
                --%>
        </td>
        <td>Phone</td>
        <td>
            <asp:TextBox ID="ActivityPhoneTextBox" runat="server" TextMode="Phone" TabIndex="9" ></asp:TextBox></td>
    </tr>
    <tr>
        <td>Address</td>
        <td>
            <asp:TextBox ID="ActivityAddress1TextBox" runat="server" TabIndex="3"></asp:TextBox></td>
        <td>Commodity</td>
        <td>
            <asp:TextBox ID="CommodityTypeTextBox" runat="server" TabIndex="10"></asp:TextBox>
<%--            <asp:DropDownList ID="CommodityTypeDropDownList" runat="server" DataSourceID="CommoditySqlDataSource" DataTextField="value" DataValueField="value" TabIndex="10"></asp:DropDownList>--%>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>
            <asp:TextBox ID="ActivityAddress2TextBox" runat="server" TabIndex="4"></asp:TextBox>
        </td>
        <td>Pickup/Delivery Date</td>
        <td>
            <asp:TextBox ID="ActivityDateTextBox" runat="server" TabIndex="11" Width="85px"></asp:TextBox><cc1:CalendarExtender ID="ActivityDateTextBoxCalendarExtender" PopupButtonID="ActivityDateTextBox" TargetControlID="ActivityDateTextBox" runat="server" /><cc1:MaskedEditExtender TargetControlID="ActivityDateTextBox" runat="server" ID="MaskedEditExtender1" Mask="99/99/9999" MaskType="Date" AcceptAMPM="false" ClearTextOnInvalid="true" />
            <asp:TextBox ID="ActivityTimeTextBox" runat="server" TabIndex="12" Width="73px"></asp:TextBox><cc1:MaskedEditExtender TargetControlID="ActivityTimeTextBox" runat="server" ID="ActivityTimeTextBoxMaskedEditExtender" Mask="99:99" MaskType="Time" AcceptAMPM="true" /> - <asp:TextBox ID="ActivityTimeEndTextBox" runat="server" TabIndex="12" Width="73px"></asp:TextBox><cc1:MaskedEditExtender TargetControlID="ActivityTimeEndTextBox" runat="server" ID="ActivityTimeEndTextBoxMaskedEditExtender" Mask="99:99" MaskType="Time" AcceptAMPM="true" /></td>
    </tr>
    <tr>
        <td>City/State/Zip</td>
        <td>
            <asp:TextBox ID="ActivityCityTextBox" runat="server" TabIndex="5"></asp:TextBox>
            <asp:DropDownList ID="ActivityStateDropdownList" runat="server" DataSourceID="StateSqlDataSource" DataTextField="Value" DataValueField="Value" TabIndex="6"></asp:DropDownList>
            <asp:TextBox ID="ActivityPostalCodeTextBox" runat="server" Width="75px" MaxLength="5" TabIndex="7"></asp:TextBox>
        </td>
        <td>Notes</td>
        <td>
            <asp:TextBox ID="ActivityNotesTextBox" runat="server" TabIndex="13"></asp:TextBox></td>
    </tr>

    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>Completion Date</td>
        <td>
            <asp:TextBox ID="CompletionDateTextBox" runat="server" TabIndex="14"></asp:TextBox>
            <cc1:MaskedEditExtender TargetControlID="CompletionDateTextBox" runat="server" ID="CompletionDateTextBoxMaskedEditExtender" Mask="99/99/9999 99:99" MaskType="DateTime" AcceptAMPM="true" />
            <%--<cc1:CalendarExtender ID="CompletionCalendarExtender" PopupButtonID="CompletionDateTextBox" TargetControlID="CompletionDateTextBox" runat="server" />--%></td>
    </tr>

</table>

    </ContentTemplate>
</asp:UpdatePanel>

<asp:SqlDataSource ID="StateSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT Value FROM l WHERE (Category = 'State') order by value"></asp:SqlDataSource>

<asp:SqlDataSource ID="CommoditySqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="select value from l where category = 'Commodity' order by displayorder, value"></asp:SqlDataSource>
