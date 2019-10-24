<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AddActivityWebUserControlSmall.ascx.vb" Inherits="CL_TicketingApp.AddActivityWebUserControlSmall" %>

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
         
        <tr runat="server" id="HeaderTableRow" visible="false">

            <td>Type</td>
            <td>Location</td>
            <td>Address</td>

            <td>City</td>
            <td>State</td>
            <td>Zip</td>

            <td>Commodity</td>
            <td>Date</td>
            <td>Time</td>
            <td>-</td>
            <td>Time</td>
            
        </tr>
      



<tr>






            <td>
                <asp:DropDownList ID="ActivityTypeDropDownList" runat="server" TabIndex="0" CssClass="form-control input-xs" style="min-width: 50px;">
                        <asp:ListItem ></asp:ListItem>
                        <asp:ListItem value="Pickup">P</asp:ListItem>
                        <asp:ListItem value="Delivery">D</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                
                <asp:UpdateProgress ID="updateProgress" runat="server" AssociatedUpdatePanelID="LocationSelectorUpdatePanel">
                    <ProgressTemplate>
                        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                            <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #FFFFFF; font-size: 36px; left: 40%; top: 40%;">Loading
                                Locations...</span>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:UpdatePanel ID="LocationSelectorUpdatePanel" runat="server" UpdateMode="always"
                    ChildrenAsTriggers="true">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox ID="LocationTextBox" runat="server" Width="250px" AutoPostBack="true" placeholder="Location"
                                        TabIndex="1" CssClass="form-control input-xs"></asp:TextBox>
                                </td>
                                <td>
                                    <uc1:CompanyPopupWrapperWebUserControl runat="server" ID="NewLocationPopUpControl" />
                                    <%--<asp:ImageButton ID="NewLocationImageButton" runat="server" AlternateText="New Location" ImageUrl="~/Images/plus1.gif" />--%>
                                </td>
                            </tr>
                        </table>
                        <div style="display:none;" tabindex="2">
                            <asp:TextBox ID="LocationIDTextBox" runat="server"></asp:TextBox>
                        </div>


                        <asp:Label ID="MCNumberLabel" runat="server"></asp:Label>
                        <asp:Label ID="LocationNumberLabel" runat="server"></asp:Label>
                        <cc1:autocompleteextender servicemethod="SearchLocations" minimumprefixlength="2"
                            completioninterval="100" enablecaching="false" completionsetcount="10" targetcontrolID="LocationTextBox"
                            ID="LocationAutoCompleteExtender" runat="server" firstrowselected="false">
                        </cc1:autocompleteextender>

                    </ContentTemplate>
                </asp:UpdatePanel>

            </td>
            <td>
                <asp:TextBox ID="ActivityAddress1TextBox" runat="server" TabIndex="3" CssClass="form-control input-xs" placeholder="Address 1"></asp:TextBox>
            </td>

            <td>
                <asp:TextBox ID="ActivityCityTextBox" runat="server" TabIndex="4" CssClass="form-control input-xs" placeholder="City"></asp:TextBox>
            </td>
            <td>
                <asp:DropDownList ID="ActivityStateDropdownList" runat="server" DataSourceID="StateSqlDataSource"
                    DataTextField="Value" DataValueField="Value" TabIndex="5" CssClass="form-control input-xs" appenddatabounditems="false">
                    <asp:ListItem text="" value="" />
                    </asp:DropDownList>
            </td>
            <td>
                <asp:TextBox ID="ActivityPostalCodeTextBox" runat="server" Width="75px" MaxLength="5" TabIndex="6"
                    CssClass="form-control input-xs" placeholder="Zip"></asp:TextBox>
            </td>

            <td>
                <asp:TextBox ID="CommodityTypeTextBox" runat="server" TabIndex="7" CssClass="form-control input-xs"  placeholder="Commodity"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="ActivityDateTextBox" runat="server" TabIndex="8" Width="85px" CssClass="form-control input-xs"  placeholder="Date"></asp:TextBox>
                <cc1:CalendarExtender ID="ActivityDateTextBoxCalendarExtender" PopupButtonID="ActivityDateTextBox"
                    TargetControlID="ActivityDateTextBox" runat="server" />
                <cc1:MaskedEditExtender TargetControlID="ActivityDateTextBox" runat="server" ID="MaskedEditExtender1"
                    Mask="99/99/9999" MaskType="Date" AcceptAMPM="false" ClearTextOnInvalID="true" />
            </td>
            <td>
                <asp:TextBox ID="ActivityTimeTextBox" runat="server" TabIndex="9" Width="73px" CssClass="form-control input-xs"  placeholder="Time"></asp:TextBox>
                <cc1:MaskedEditExtender TargetControlID="ActivityTimeTextBox" runat="server" ID="ActivityTimeTextBoxMaskedEditExtender"
                    Mask="99:99" MaskType="Time" AcceptAMPM="true"  />
            </td>
            <td>-</td>
            <td>
                <asp:TextBox ID="ActivityTimeEndTextBox" runat="server" TabIndex="10" Width="73px" CssClass="form-control input-xs"  placeholder="Time"></asp:TextBox>
                <cc1:MaskedEditExtender TargetControlID="ActivityTimeEndTextBox" runat="server" ID="ActivityTimeEndTextBoxMaskedEditExtender"
                    Mask="99:99" MaskType="Time" AcceptAMPM="true" />
            </td>
          
        </tr>

        <tr>
            <td></td>

            <td>
                <asp:TextBox ID="ActivityContactTextBox" runat="server" TabIndex="11" CssClass="form-control input-xs"  placeholder="Local Contact"></asp:TextBox>
            </td>

            <td>
                <asp:TextBox ID="ActivityAddress2TextBox" runat="server" TabIndex="12" CssClass="form-control input-xs"  placeholder="Address 2"></asp:TextBox>
            </td>
            <td><asp:TextBox CssClass="form-control input-xs" ID="ActivityPhoneTextBox" runat="server" TextMode="Phone" TabIndex="13"  placeholder="Phone" ></asp:TextBox></td>
    
            <td colspan="7"><asp:TextBox ID="ActivityNotesTextBox" runat="server" TabIndex="14" CssClass="form-control input-xs"  placeholder="Notes" style="min-width:100%"></asp:TextBox><asp:TextBox ID="CompletionDateTextBox" runat="server" visble="false" style="display: none;"></asp:TextBox></td>
         
           
     </tr>  
</table>
    </ContentTemplate>
</asp:UpdatePanel>
 
<asp:SqlDataSource ID="StateSqlDataSource" EnableCaching="true" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT Value FROM l WHERE (Category = 'State') order by value"></asp:SqlDataSource>

<%--<asp:SqlDataSource ID="CommoditySqlDataSource" EnableCaching="true" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="select value from l where category = 'Commodity' order by displayorder, value"></asp:SqlDataSource>--%>
