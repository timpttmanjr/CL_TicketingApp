<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="BOLScanner2.aspx.vb" Inherits="CL_TicketingApp.BolScanner2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        window.history.forward();
        function noBack() { window.history.forward(); }

    </script>
    <script type="text/javascript" language="javascript" src="Resources/dynamsoft.webtwain.initiate.js"></script>
    <script type="text/javascript" language="javascript" src="Resources/dynamsoft.webtwain.config.js"></script>
    <script type="text/javascript">
    function SaveToDB() {
            var strHTTPServer = location.hostname; //The name of the HTTP server. 
            var CurrentPathName = unescape(location.pathname);
            var CurrentPath = CurrentPathName.substring(0, CurrentPathName.lastIndexOf("/") + 1);
            var strActionPage = CurrentPath + "scanSave2.aspx";
            if (strHTTPServer.indexOf("localhost") > -1) {
                DWObject.IfSSL = false; // Set whether SSL is used
                DWObject.HTTPPort = location.port == "" ? 80 : location.port;
            }
            else {
                DWObject.IfSSL = true; // Set whether SSL is used
                DWObject.HTTPPort = 443
            }
            return DWObject.HTTPUploadAllThroughPostAsPDF(
              strHTTPServer,
              strActionPage,
              "fakedocname.pdf"
            );
        }
    </script>
    
    <script type="text/javascript">
            Dynamsoft.WebTwainEnv.RegisterEvent('OnWebTwainReady', Dynamsoft_OnReady); // Register OnWebTwainReady event. This event fires as soon as Dynamic Web TWAIN is initialized and ready to be used
            var DWObject;
            function Dynamsoft_OnReady() {
                DWObject = Dynamsoft.WebTwainEnv.GetWebTwain('dwtcontrolContainer'); // Get the Dynamic Web TWAIN object that is embeded in the div with id 'dwtcontrolContainer'
                if (DWObject) {
                    var count = DWObject.SourceCount;
                    if (count == 0 && Dynamsoft.Lib.env.bMac) {
                        DWObject.CloseSourceManager();
                        DWObject.ImageCaptureDriverType = 0;
                        DWObject.OpenSourceManager();
                        count = DWObject.SourceCount;
                    }

                    for (var i = 0; i < count; i++)
                        document.getElementById("source").options.add(new Option(DWObject.GetSourceNameItems(i), i));
                }
            }
            function AcquireImage() {
                if (DWObject) {
                    var OnAcquireImageSuccess
                    OnAcquireImageSuccess = function () {
                        DWObject.CloseSource();
                    };
                    var OnAcquireImageFailure;
                     OnAcquireImageFailure = function () {
                        DWObject.CloseSource();
                    };
                    DWObject.SelectSourceByIndex(document.getElementById("source").selectedIndex);
                    DWObject.OpenSource();
                    DWObject.IfDisableSourceAfterAcquire = true;
                    if (document.getElementById("BW").checked)
                        DWObject.PixelType = EnumDWT_PixelType.TWPT_BW;
                    else if (document.getElementById("Gray").checked)
                        DWObject.PixelType = EnumDWT_PixelType.TWPT_GRAY;
                    else if (document.getElementById("RGB").checked)
                        DWObject.PixelType = EnumDWT_PixelType.TWPT_RGB;
                    DWObject.IfFeederEnabled = true;
                    DWObject.IfShowUI = document.getElementById("ShowUI").checked;
                    DWObject.Resolution = parseInt(document.getElementById("Resolution").value);
                    var bDuplexChecked = document.getElementById("Duplex").checked;
                    DWObject.IfDuplexEnabled = bDuplexChecked;
                        if (DWObject.IfFeederLoaded != true && DWObject.ErrorCode == 0) {
                            alert("No paper detected! Please load papers and try again!");
                            return;
                        }
                    DWObject.AcquireImage(OnAcquireImageSuccess, OnAcquireImageFailure);
                }
            }
        //************************** Edit Image ******************************
        function checkIfImagesInBuffer() {
            if (DWObject.HowManyImagesInBuffer == 0) {
                return false;
            }
            else
                return true;
        }
        function btnShowImageEditor_onclick() {
            if (!checkIfImagesInBuffer()) {
                return;
            }
            DWObject.ShowImageEditor();
        }
        function btnRotateRight_onclick() {
            if (!checkIfImagesInBuffer()) {
                return;
            }
            DWObject.RotateRight(DWObject.CurrentImageIndexInBuffer);
            if (checkErrorString()) {
                return;
            }
        }
        function btnRotateLeft_onclick() {
            if (!checkIfImagesInBuffer()) {
                return;
            }
            DWObject.RotateLeft(DWObject.CurrentImageIndexInBuffer);
            if (checkErrorString()) {
                return;
            }
        }
        function btnRotate180_onclick() {
            if (!checkIfImagesInBuffer()) {
                return;
            }
            DWObject.Rotate(DWObject.CurrentImageIndexInBuffer, 180, true);
            if (checkErrorString()) {
                return;
            }
        }
        function btnMirror_onclick() {
            if (!checkIfImagesInBuffer()) {
                return;
            }
            DWObject.Mirror(DWObject.CurrentImageIndexInBuffer);
            if (checkErrorString()) {
                return;
            }
        }
        function btnFlip_onclick() {
            if (!checkIfImagesInBuffer()) {
                return;
            }
            DWObject.Flip(DWObject.CurrentImageIndexInBuffer);
            if (checkErrorString()) {
                return;
            }
        }
        </script>
    <div class="row">
                <div class="col-md-12 col-lg-22">
                    <h1>BOL Document Scanner</h1>
                    <p class="lead">Scanned images are saved to Azure.</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 col-lg-3">
                    <div class="form-group">
                        <label class="control-label">Image type</label><br />
                        <div class="radio">
                            <label for="BW"><input type="radio" id="BW" name="PixelType"  checked="checked"/>Black and White</label><br />
                            <label for="Gray"><input type="radio" id="Gray" name="PixelType" />Grayscale</label><br />
                            <label for="RGB"><input type="radio" id="RGB" name="PixelType" />Color</label><br />
                        </div>
                        <label class="control-label">Scan Options</label><br />
                        <div class="checkbox">
                            <label for = 'Duplex'><input type='checkbox' id='Duplex'/>Duplex</label><br />
                        </div>
                        <div class="checkbox">
                            <label for = 'ShowUI'><input type='checkbox' id='ShowUI'/>Show UI</label><br />
                        </div>

                        <label class="control-label">Resolution</label><br />
                        <select size="1" id="Resolution" class="form-control">
                            <option value="100">100</option>
                            <option value="150">150</option>
                            <option value="200" selected="selected">200</option>
                            <option value="300">300</option>
                        </select>
                        <br />
                        <br />
                        <label class="control-label">Scanner</label><br />
                        <select size="1" id="source" class="form-control"></select><br />
                        <input class="btn btn-default" type="button" value="Scan" onclick="AcquireImage();" />
                         <img src="Images/RotateLeft.png" title="Rotate Left" alt="Rotate Left" id="btnRotateL"  onclick="btnRotateLeft_onclick()"/> 
                        <img src="Images/RotateRight.png" title="Rotate Right" alt="Rotate Right" id="btnRotateR"  onclick="btnRotateRight_onclick()"/> 
                        <img src="Images/Rotate180.png" alt="Rotate 180" title="Rotate 180" onclick="btnRotate180_onclick()" /> 
                        <img src="Images/Mirror.png" title="Mirror" alt="Mirror" id="btnMirror"  onclick="btnMirror_onclick()"/> 
                        <img src="Images/Flip.png" title="Flip" alt="Flip" id="btnFlip" onclick="btnFlip_onclick()"/> 
                        <br /><br />
                        <asp:Button ID="Button1" Enabled="true" runat="server" CssClass="btn btn-default" Text="Save to Imaging" OnClientClick="return SaveToDB();" OnClick="btnUpload_OnClick" />
                        <asp:Button ID="CancelButton" Enabled="true" runat="server" CssClass="btn btn-default" Text="Cancel / Return" OnClick="CancelButton_OnClick" />
                        <asp:Button ID="btnDelete" Enabled="true" runat="server" CssClass="btn btn-default" Text="Delete the Image" OnClientClick="return confirm('Are you sure you want to permanently remove this item?')" OnClick="btnDelete_OnClick" />
                    </div>
                </div>
                <div class="col-md-9 col-lg-9">
                    <div id="dwtcontrolContainer"></div>
                </div>
            </div>

    <!-- Bootstrap Modal Dialog -->
    <div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <asp:UpdatePanel ID="upModal" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"><asp:Label ID="lblModalTitle" runat="server" Text=""></asp:Label></h4>
                        </div>
                        <div class="modal-body">
                            <asp:Label ID="lblModalBody" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

</asp:Content>