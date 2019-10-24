<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CompanyPopupWrapperWebUserControl.ascx.vb" Inherits="CL_TicketingApp.CompanyPopupWrapperWebUserControl" %>
<style type="text/css">
        .modalBackground {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .modalPopup {
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


    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
    <%@ Register Src="~/CompanyPopupEditorWebUserControl.ascx" TagPrefix="uc1" TagName="CompanyPopupEditorWebUserControl" %>




    <cc1:ModalPopupExtender ID="CompanyModalPopupExtender" runat="server" TargetControlID="CompanyPopupLink"
        PopupControlID="CompanyPopupPanel" BackgroundCssClass="modalBackground"
        CancelControlID="CancelButton" PopupDragHandleControlID="CompanyPopupPanel">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="CompanyPopupPanel" runat="server" Width="700px" CssClass="modalPopup">
        <table width="100%" cellpadding="3">
            <tr class="accordionHeaderStatic">
                <td align="left" width="100%">Company Editor</td>
            </tr>
            <tr>
                <td>
                    <uc1:CompanyPopupEditorWebUserControl runat="server" ID="CompanyPopupEditorWebUserControl1" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="MessageLabel" runat="server" ForeColor="Red" Text=""></asp:Label><br />
                   <asp:Button ID="SaveButton" ValidationGroup="CompanyPopup" runat="server" Text="Save" OnClick="SaveButton_Click" />
                    <asp:Button ID="CancelButton" ValidationGroup="CompanyPopup" runat="server" Text="Cancel" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <a id="CompanyPopupLink" href="#" runat="server" tabindex="1000"><img src="Images/plus1.gif" /></a>