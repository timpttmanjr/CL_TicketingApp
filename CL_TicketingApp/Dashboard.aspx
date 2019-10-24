<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Dashboard.aspx.vb" Inherits="CL_TicketingApp.Dashboard" EnableEventValidation="false" %>



<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="AddActivityWebUserControlSmall.ascx" TagName="AddActivityWebUserControlSmall" TagPrefix="uc1" %>
<%@ Register Src="~/CompanyPopupWrapperWebUserControl.ascx" TagPrefix="uc1" TagName="CompanyPopupWrapperWebUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Dashboard</h1>
    <style>
        .input-xs {
            height: 22px;
            padding: 2px 5px;
            font-size: 12px;
            line-height: 1.5;
            /* If Placeholder of the input is moved up, rem/modify this. */
            border-radius: 3px;
        }
    </style>

     <script type="text/javascript">
        
    function CarrierItemSelected(sender, e) {
        $get("<%=CarrierIDHiddenField.ClientID%>").value = e.get_value();
    }
    </script>
 
    <asp:UpdatePanel ID="EntryPanel" runat="server">
        <ContentTemplate>
    <table>
        <tr>

            <td>Customer</td>
            <td>Contact</td>
            <td>Load Type</td>
            <td>Tarp</td>
            <td>Weight</td>
            <td>Bill</td>
            <td>Extra $</td>
            <td>Extra $ Descr</td>
            <td>PO</td>
            <td>P</td>
        </tr>
        <tr>

            <td>
                <asp:DropDownList placeholder="Customer" CssClass="form-control input-xs" ID="CustomerDropDownList"
                    runat="server" DataSourceID="CompanySqlDataSource" DataTextField="CompanyName" DataValueField="ID"></asp:DropDownList>
            </td>
            <td>
                <asp:TextBox CssClass="form-control input-xs" runat="server" ID="CustomerContactTextBox"  placeholder="Contact"
                    ></asp:TextBox>
            </td>
           
            <td>
                <asp:DropDownList CssClass="form-control input-xs" ID="LoadTypeDropDownList" runat="server"
                    DataSourceID="LoadTypeSqlDataSource" DataTextField="Value" DataValueField="Value" >
                </asp:DropDownList>
                <asp:SqlDataSource ID="LoadTypeSqlDataSource" EnableCaching="true" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
                    SelectCommand="select value from l where category = 'Equipment' order by displayorder, value"></asp:SqlDataSource>
            </td>
            <td>
                <asp:DropDownList CssClass="form-control input-xs" ID="TarpDropDownList" runat="server" style="min-width: 50px;" >
                    <asp:ListItem Text="Y" Value="Yes"></asp:ListItem>
                    <asp:ListItem Text="N" Value="No" Selected="true"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td><asp:TextBox CssClass="form-control input-xs" ID="WeightTextBox" runat="server" placeholder="Weight"></asp:TextBox></td>
            <td>
                <asp:TextBox CssClass="form-control input-xs" runat="server" ID="CustomerBillAmount"  placeholder="Bill"
                    textmode="Number"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox placeholder="Extra $" CssClass="form-control input-xs" ID="ExtraCharge1AmountTextBox"
                    runat="server" textmode="Number"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox placeholder="Description" CssClass="form-control input-xs" ID="ExtraCharge1DescriptionTextBox"
                    runat="server" ></asp:TextBox>
            </td>
            <td colspan="2">
                <asp:TextBox placeholder="PONumber" CssClass="form-control input-xs" ID="POTextBox"
                    runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:DropDownList ID="PriorityDropDownList" runat="server" ToolTip="Order Priority (High, Medium, Low)">
                    <asp:ListItem Text="H" Value="1"></asp:ListItem>
                    <asp:ListItem Text="M" Value="2" Selected="true"></asp:ListItem>
                    <asp:ListItem Text="L" Value="3"></asp:ListItem>
                </asp:DropDownList>
            </td>

        </tr>



        <tr>

                <td><asp:TextBox CssClass="form-control input-xs" ID="CitationContactTextBox" runat="server" placeholder="Citation Contact"></asp:TextBox></td>

                <td colspan="9"><asp:TextBox CssClass="form-control input-xs" ID="NotesTextBox" runat="server" style="min-width:100%" placeholder="Additional Notes"></asp:TextBox></td>
               
              
            </tr>
       <tr>

            <td><asp:UpdateProgress id="updateProgress" runat="server" AssociatedUpdatePanelID="CarrierSelectorUpdatePanel">
    <ProgressTemplate>
        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
            <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #FFFFFF; font-size: 36px; left: 40%; top: 40%;">Loading Carrier...</span>
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>
    <asp:UpdatePanel ID="CarrierSelectorUpdatePanel" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                     
                <asp:HiddenField ID="CarrierIDHiddenField" runat="server" />


                        <table><tr><td><asp:TextBox ID="CarrierTextBox" runat="server" Width="650px" AutoPostBack="true"  placeholder="Carrier" CssClass="form-control input-xs"></asp:TextBox></td>
                            <td> <uc1:CompanyPopupWrapperWebUserControl runat="server" ID="NewCarrierPopUpControl" /></td></tr></table>

                        
                       
                        <%--<asp:ImageButton ID="NewCarrierImageButton" runat="server" AlternateText="New Carrier" ImageUrl="~/Images/plus1.gif" />--%>
                        <asp:Label ID="CarrierNumberLabel" runat="server"></asp:Label>
                        <cc1:AutoCompleteExtender ServiceMethod="SearchCarriers"
                            MinimumPrefixLength="2"
                            CompletionInterval="100" EnableCaching="false" CompletionSetCount="50"
                            TargetControlID="CarrierTextBox"
                            ID="CarrierAutoCompleteExtender" runat="server" FirstRowSelected="false" OnClientItemSelected="CarrierItemSelected">
                        </cc1:AutoCompleteExtender>
                        </ContentTemplate></asp:UpdatePanel>
                        
                        </td>
            <td><asp:TextBox ID="CarrierContactTextBox" runat="server"  placeholder="Carrier Contact" CssClass="form-control input-xs"></asp:TextBox></td>
            <td><asp:TextBox ID="CarrierPhoneTextBox" runat="server" TextMode="Phone"  placeholder="Carrier Phone" CssClass="form-control input-xs"></asp:TextBox></td>
            <td><asp:TextBox ID="CarrierFaxTextBox" runat="server" TextMode="Phone"  placeholder="Carrier Fax" CssClass="form-control input-xs"></asp:TextBox></td>
            <td><asp:TextBox ID="EmailTextBox" runat="server" TextMode="Email"  placeholder="Carrier Email" CssClass="form-control input-xs"></asp:TextBox></td>
            <td><asp:TextBox ID="DriverNameTextBox" runat="server"  placeholder="Driver" CssClass="form-control input-xs"></asp:TextBox></td>
            <td><asp:TextBox ID="CellPhoneTextBox" runat="server" TextMode="Phone" placeholder="Driver Cell" CssClass="form-control input-xs"></asp:TextBox></td>
            <td><asp:TextBox  ID="CarrierPayAmountTextBox" runat="server" TextMode="Number" placeholder="Carrier Pay" CssClass="form-control input-xs"></asp:TextBox></td>
            <td><asp:TextBox  ID="ExtraPay1AmountTextBox" runat="server" placeholder="Extra Pay" TextMode="Number" CssClass="form-control input-xs"></asp:TextBox></td>
            <td></td>
        </tr>
    </table>









            

                   
             
















    
     <uc1:AddActivityWebUserControlSmall ID="AddActivityWebUserControl1" runat="server" ActivityItem="a1" tabindex="100" />
        <uc1:AddActivityWebUserControlSmall ID="AddActivityWebUserControl2" runat="server" ActivityItem="a2" tabindex="200"  />
        <span id="ActivityRow3" style="display:none;"><uc1:AddActivityWebUserControlSmall ID="AddActivityWebUserControl3" runat="server" ActivityItem="a3" tabindex="400"  /></span>
        <span id="ActivityRow4" style="display:none;"><uc1:AddActivityWebUserControlSmall ID="AddActivityWebUserControl4" runat="server"  ActivityItem="a4" tabindex="500"   /></span>
    <br />
<table style="width:100%">
    <tr>
        <td>
            <a tabindex="601" id="ShowMoreActivites" class="btn btn-sm btn-default" onclick='document.getElementById("ActivityRow3").style.display= "";document.getElementById("ActivityRow4").style.display= ""; this.style.display="none"; document.getElementById("ShowLessActivites").style.display= "";'>+</a>
            <a tabindex="602" id="ShowLessActivites" style="display:none;" class="btn btn-sm btn-default" onclick='document.getElementById("ActivityRow3").style.display= "none";document.getElementById("ActivityRow4").style.display= "none"; this.style.display="none"; document.getElementById("ShowMoreActivites").style.display= "";'>-</a>
         
        </td>
        <td style="text-align: right;">
           <asp:Button runat="Server" id="SaveButton" CssClass="btn btn-primary btn-sm" text="Save" TabIndex="603"/>&nbsp;<asp:Button runat="Server" id="ResetButton" CssClass="btn btn-warning btn-sm" text="Reset" TabIndex="604"/>

        </td>
    </tr>
</table>         

 <asp:SqlDataSource ID="OrdersSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
        DeleteCommand="DELETE FROM [ShippingOrder] WHERE [ShippingOrderID] = @ShippingOrderID" InsertCommand="INSERT INTO [ShippingOrder] ([CustomerCompanyID], [CarrierCompanyID], [CarrierContact], [CarrierPhone], [CarrierFax], [CarrierEmail], [Notes], [CustomerPONumber], [CustomerBillAmount], [CarrierPayAmount], [CarrierDriverName], [CarrierDriverCell], [CommodityType], [LoadType], [Tarp], [Weight], [StatusType], [CitationContact], [OrderNumber], [OrderDate], [a1ActivityType], [a1LocationCompanyID], [a1Address1], [a1Address2], [a1City], [a1State], [a1PostalCode], [a1Notes], [a1CompletionDate], [a1Status], [a1ActivityDate], [a1CommodityType], [a1Phone], [a2ActivityType], [a2LocationCompanyID], [a2Address1], [a2Address2], [a2City], [a2State], [a2PostalCode], [a2Notes], [a2CompletionDate], [a2Status], [a2ActivityDate], [a2CommodityType], [a2Phone], [a3ActivityType], [a3LocationCompanyID], [a3Address1], [a3Address2], [a3City], [a3State], [a3PostalCode], [a3Notes], [a3CompletionDate], [a3Status], [a3ActivityDate], [a3CommodityType], [a3Phone], [a4ActivityType], [a4LocationCompanyID], [a4Address1], [a4Address2], [a4City], [a4State], [a4PostalCode], [a4Notes], [a4CompletionDate], [a4Status], [a4ActivityDate], [a4CommodityType], [a4Phone], a1Contact, a2Contact, a3Contact, a4Contact, a1ActivityTime, a2ActivityTime, a3ActivityTime, a4ActivityTime, ExtraCharge1Amount, ExtraCharge1Description, ExtraPay1Amount, ExtraPay1Description,a1ActivityTimeEnd ,a2ActivityTimeEnd ,a3ActivityTimeEnd , a4ActivityTimeEnd ,CustomerContact, PO, Priority) VALUES (@CustomerCompanyID, @CarrierCompanyID, @CarrierContact, @CarrierPhone, @CarrierFax, @CarrierEmail, @Notes, @CustomerPONumber, @CustomerBillAmount, @CarrierPayAmount, @CarrierDriverName, @CarrierDriverCell, @CommodityType, @LoadType, @Tarp, @Weight, @StatusType, @CitationContact, @OrderNumber, @OrderDate, @a1ActivityType, @a1LocationCompanyID, @a1Address1, @a1Address2, @a1City, @a1State, @a1PostalCode, @a1Notes, @a1CompletionDate, @a1Status, @a1ActivityDate, @a1CommodityType, @a1Phone, @a2ActivityType, @a2LocationCompanyID, @a2Address1, @a2Address2, @a2City, @a2State, @a2PostalCode, @a2Notes, @a2CompletionDate, @a2Status, @a2ActivityDate, @a2CommodityType, @a2Phone, @a3ActivityType, @a3LocationCompanyID, @a3Address1, @a3Address2, @a3City, @a3State, @a3PostalCode, @a3Notes, @a3CompletionDate, @a3Status, @a3ActivityDate, @a3CommodityType, @a3Phone, @a4ActivityType, @a4LocationCompanyID, @a4Address1, @a4Address2, @a4City, @a4State, @a4PostalCode, @a4Notes, @a4CompletionDate, @a4Status, @a4ActivityDate, @a4CommodityType, @a4Phone, @a1Contact, @a2Contact, @a3Contact, @a4Contact, @a1ActivityTime, @a2ActivityTime, @a3ActivityTime, @a4ActivityTime, @ExtraCharge1Amount, @ExtraCharge1Description, @ExtraPay1Amount, @ExtraPay1Description,@a1ActivityTimeEnd ,@a2ActivityTimeEnd ,@a3ActivityTimeEnd , @a4ActivityTimeEnd ,@CustomerContact, @PO, @Priority)">
        <DeleteParameters>
            <asp:Parameter Name="ShippingOrderID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerCompanyID" />
            <asp:Parameter Name="CarrierCompanyID" />
            <asp:Parameter Name="CarrierContact" Type="String" />
            <asp:Parameter Name="CarrierPhone" Type="String" />
            <asp:Parameter Name="CarrierFax" Type="String" />
            <asp:Parameter Name="CarrierEmail" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="CustomerPONumber" Type="String" />
            <asp:Parameter Name="CustomerBillAmount" />
            <asp:Parameter Name="CarrierPayAmount" />
            <asp:Parameter Name="CarrierDriverName" Type="String" />
            <asp:Parameter Name="CarrierDriverCell" Type="String" />
            <asp:Parameter Name="CommodityType" Type="String" />
            <asp:Parameter Name="LoadType" Type="String" />
            <asp:Parameter Name="Tarp" Type="String" />
            <asp:Parameter Name="Weight" Type="String" />
            <asp:Parameter Name="StatusType" Type="String" />
            <asp:Parameter Name="CitationContact" Type="String" />
            <asp:Parameter Name="OrderNumber" />
            <asp:Parameter DbType="Date" Name="OrderDate" />
            <asp:Parameter Name="a1ActivityType" Type="String" />
            <asp:Parameter Name="a1LocationCompanyID" />
            <asp:Parameter Name="a1Address1" Type="String" />
            <asp:Parameter Name="a1Address2" Type="String" />
            <asp:Parameter Name="a1City" Type="String" />
            <asp:Parameter Name="a1State" Type="String" />
            <asp:Parameter Name="a1PostalCode" Type="String" />
            <asp:Parameter Name="a1Notes" Type="String" />
            <asp:Parameter Name="a1CompletionDate" />
            <asp:Parameter Name="a1Status" Type="String" />
            <asp:Parameter Name="a1ActivityDate" Type="String" />
            <asp:Parameter Name="a1CommodityType" Type="String" />
            <asp:Parameter Name="a1Phone" Type="String" />
            <asp:Parameter Name="a2ActivityType" Type="String" />
            <asp:Parameter Name="a2LocationCompanyID" />
            <asp:Parameter Name="a2Address1" Type="String" />
            <asp:Parameter Name="a2Address2" Type="String" />
            <asp:Parameter Name="a2City" Type="String" />
            <asp:Parameter Name="a2State" Type="String" />
            <asp:Parameter Name="a2PostalCode" Type="String" />
            <asp:Parameter Name="a2Notes" Type="String" />
            <asp:Parameter Name="a2CompletionDate" />
            <asp:Parameter Name="a2Status" Type="String" />
            <asp:Parameter Name="a2ActivityDate" Type="String" />
            <asp:Parameter Name="a2CommodityType" Type="String" />
            <asp:Parameter Name="a2Phone" Type="String" />
            <asp:Parameter Name="a3ActivityType" Type="String" />
            <asp:Parameter Name="a3LocationCompanyID" />
            <asp:Parameter Name="a3Address1" Type="String" />
            <asp:Parameter Name="a3Address2" Type="String" />
            <asp:Parameter Name="a3City" Type="String" />
            <asp:Parameter Name="a3State" Type="String" />
            <asp:Parameter Name="a3PostalCode" Type="String" />
            <asp:Parameter Name="a3Notes" Type="String" />
            <asp:Parameter Name="a3CompletionDate" />
            <asp:Parameter Name="a3Status" Type="String" />
            <asp:Parameter Name="a3ActivityDate" Type="String" />
            <asp:Parameter Name="a3CommodityType" Type="String" />
            <asp:Parameter Name="a3Phone" Type="String" />
            <asp:Parameter Name="a4ActivityType" Type="String" />
            <asp:Parameter Name="a4LocationCompanyID" />
            <asp:Parameter Name="a4Address1" Type="String" />
            <asp:Parameter Name="a4Address2" Type="String" />
            <asp:Parameter Name="a4City" Type="String" />
            <asp:Parameter Name="a4State" Type="String" />
            <asp:Parameter Name="a4PostalCode" Type="String" />
            <asp:Parameter Name="a4Notes" Type="String" />
            <asp:Parameter Name="a4CompletionDate" />
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
            <asp:Parameter Name="PO" Type="String" />
            <asp:Parameter Name="Priority" Type="String" />

        </InsertParameters>

    </asp:SqlDataSource>
      
        
        
        
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="SaveButton" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="ResetButton" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>




    <asp:SqlDataSource ID="StateSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
        SelectCommand="SELECT Value FROM l WHERE (Category = 'State') order by value"></asp:SqlDataSource>

    <asp:SqlDataSource ID="CommoditySqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
        SelectCommand="select value from l where category = 'Commodity' order by displayorder, value"></asp:SqlDataSource>



    <asp:SqlDataSource ID="CompanySqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
        SelectCommand="SELECT CompanyName, id FROM Company where customer = 1 and isnull(disabled,0) = 0 ORDER BY CompanyName"></asp:SqlDataSource>


   

<hr>



<asp:UpdatePanel ID="GridResultsPanel" runat="server" ChildrenAsTriggers="true">
    <ContentTemplate>




<table>
    <tr>
                <td><asp:DropDownList  ID="OrderStatusDropDownList" runat="server" TabIndex="700" cssClass="form-control input-xs" >
                        <asp:ListItem selected="true" value="Pending">Pending</asp:ListItem>
                        <asp:ListItem selected="false" value="Assigned">Assigned</asp:ListItem>
                    
                </asp:DropDownList>
 
  



    
    </td>
        <td>
            &nbsp;orders between&nbsp;
        </td>



        <td><asp:TextBox cssClass="form-control input-xs" ID="StartDateTextBox" runat="server" Width="85px"  TabIndex="701"></asp:TextBox></td>
        <td>&nbsp;and&nbsp</td>
        <td><asp:TextBox cssClass="input-xs" ID="EndDateTextBox" runat="server" Width="85px"  TabIndex="702"></asp:TextBox></td>
        <td>&nbsp;or order number is&nbsp;</td>
        <td><asp:TextBox cssClass="form-control input-xs" ID="OrderNumberTextBox" runat="server" Width="85px"  TabIndex="703"></asp:TextBox></td>
        <td>&nbsp;or carrier is&nbsp;</td>
        <td><asp:DropDownList cssClass="form-control input-xs" ID="CarrierDropDownList" runat="server" AppendDataBoundItems="True" DataSourceID="CarriersSqlDataSource" DataTextField="CompanyName" DataValueField="Id"  TabIndex="704">
        <asp:ListItem Selected="True" Value="">Any Carrier</asp:ListItem>
    </asp:DropDownList></td>
        <td><asp:Button ID="SearchButton" runat="server" Text="Search"  cssClass="btn btn-primary btn-sm input-xs"  TabIndex="705"/></td>
        <td>&nbsp;<span class="badge badge-primary badge-pill">
            <asp:Label ID="CountLabel" runat="server" ></asp:Label></span></td>
</tr>
    
   
</table>


<asp:SqlDataSource ID="CarriersSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT Company.Id, Company.CompanyName FROM Company WITH (nolock) INNER JOIN ShippingOrder WITH (nolock) ON Company.Id = ShippingOrder.CarrierCompanyID where shippingorder.statustype not in ('Billed','Cancelled') ORDER BY Company.CompanyName"></asp:SqlDataSource>


<cc1:CalendarExtender ID="StartDateTextBoxCalendarExtender" PopupButtonID="StartDateTextBox" TargetControlID="StartDateTextBox" runat="server" />
<cc1:CalendarExtender ID="EndDateTextBoxCalendarExtender" PopupButtonID="EndDateTextBox" TargetControlID="EndDateTextBox" runat="server" />
<br />
<br />

<asp:GridView TabIndex="800" cssclass="table table-hover table-striped table-sm input-xs" ID="OrdersGridView" OnInit="OrdersGridView_Init" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="ShippingOrderID" DataSourceID="ShippingOrdersSqlDataSource" ForeColor="Black" GridLines="Vertical" Width="100%" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" AllowSorting="True">
    
    <Columns>
        <asp:TemplateField SortExpression="OrderNumber"><ItemTemplate>
                <asp:label runat="server" id="OrderNumber" text='<%# Eval("OrderNumber")%>'></asp:label><br/>
                <asp:label runat="server" id="StatusTypeLabel" text='<%# Eval("StatusType")%>'></asp:label><br/>
                <asp:label runat="server" id="OrderDateLabel" text='<%# if(Eval("OrderDate") Is Dbnull.Value,"", string.format(Eval("OrderDate"),"{0:d}")) %>' ></asp:label><br/>
              
            <asp:label CssClass="badge badge-danger" runat="server" id="HighPriortyBadgeLabel" text="High Priority" Visible='<%#If(Eval("Priority") = "1", True, False) %>'></asp:label>
              
            
        </ItemTemplate></asp:TemplateField>
       
        <asp:BoundField DataField="CustomerName" HeaderText="Customer" SortExpression="CustomerName" />
        <asp:TemplateField SortExpression="CarrierName" HeaderText="Carrier"><ItemTemplate>
            <asp:HyperLink ID="CarrierHyperlink" runat="server" Target="_blank" Text='<%# Eval("CarrierName") %>' NavigateUrl='<%# String.Format("~/CompanyEditor.aspx?coid={0}", Eval("CarrierCompanyID")) %>'></asp:HyperLink>
                <%--<asp:label runat="server" id="CarrierNameLabel" text='<%# Eval("CarrierName")%>'></asp:label>--%><br/>
                Pay: <asp:label runat="server" id="CarrierPayAmountLabel" text='<%# String.Format("{0:c}", Eval("CarrierPayAmount"))%>'></asp:label><br/>

                Carrier: <asp:label runat="server" id="CarrierPhoneLabel" text='<%# Eval("CarrierPhone")%>'></asp:label><br/>
                Driver: <asp:label runat="server" id="CarrierDriverCellLabel" text='<%# Eval("CarrierDriverCell")%>'></asp:label><br />
         
            <asp:HiddenField ID="CarrierNameHiddenField" runat="server" value='<%# Eval("CarrierName")%>' />

         <asp:HiddenField ID="CargoInsuranceExpirationDateHiddenField" runat="server" value='<%# Eval("CargoInsuranceExpirationDate")%>' />
         <asp:HiddenField ID="LiabilityInsuranceExpirationDateHiddenField" runat="server" value='<%# Eval("LiabilityInsuranceExpirationDate")%>' />
         <asp:HiddenField ID="MCNumberHiddenField" runat="server" value='<%# Eval("MCNumber")%>' />
         <asp:HiddenField ID="PriorityHiddenField" runat="server" value='<%# Eval("Priority")%>' />

           <%-- Cargo Ins: <span id="CargoInsuranceBadge" runat="server" class=""><asp:label runat="server" id="CargoInsuranceBadgeLabel" Text="..." ></asp:label></span><br />
            Liability Ins: <span id="LiabilityInsuranceBadge" runat="server" class=""><asp:label runat="server" id="LiabilityInsuranceBadgeLabel" Text="..." ></asp:label></span><br />
            MC: <span id="MCNumberBadge" runat="server" class=""><asp:label runat="server" id="MCNumberBadgeLabel" Text="..." ></asp:label></span>
            
            --%>
            <span id="CarrierInfoBadge" runat="server" class=""><asp:label runat="server" id="CarrierInfoMessage" Text="" ></asp:label></span>
        </ItemTemplate></asp:TemplateField>



        <asp:TemplateField SortExpression="" HeaderText="Commodity / Load"><ItemTemplate>

                <asp:label runat="server" id="CommodityTypeLabel" text='<%# Eval("CommodityType")%>'></asp:label><br/>
                <asp:label runat="server" id="LoadTypeLabel" text='<%# Eval("LoadType")%>'></asp:label>                              
        </ItemTemplate></asp:TemplateField>
  
       
  


        <asp:TemplateField SortExpression="" HeaderText="Stops"><ItemTemplate>

                <asp:label runat="server" id="a1ActivityTypeLabel" text='<%# Left(Eval("a1ActivityType"),1) + ":&nbsp;" %>' visible='<%# Eval("a1ActivityType").Length > 1 %>'></asp:label><asp:label runat="server" id="Location1CompanyNameLabel" text='<%# Eval("Location1CompanyName")%>'></asp:label>
                          
                <asp:label runat="server" id="a2ActivityTypeLabel" text='<%# "<br />" + Left(Eval("a2ActivityType"),1) + ":&nbsp;" %>' visible='<%# Eval("a2ActivityType").Length > 1 %>'></asp:label><asp:label runat="server" id="Location2CompanyNameLabel" text='<%# Eval("Location2CompanyName")%>'></asp:label>
                <asp:label runat="server" id="a3ActivityTypeLabel" text='<%# "<br />" + Left(Eval("a3ActivityType"),1) + ":&nbsp;" %>' visible='<%# Eval("a3ActivityType").Length > 1 %>'></asp:label><asp:label runat="server" id="Location3CompanyNameLabel" text='<%# Eval("Location3CompanyName")%>'></asp:label>
                <asp:label runat="server" id="a4ActivityTypeLabel" text='<%# "<br />" + Left(Eval("a4ActivityType"),1) + ":&nbsp;" %>' visible='<%# Eval("a4ActivityType").Length > 1 %>'></asp:label><asp:label runat="server" id="Location4CompanyNameLabel" text='<%# Eval("Location4CompanyName")%>'></asp:label>
                                                                            
        </ItemTemplate></asp:TemplateField>



        <asp:TemplateField><ItemTemplate>
            <%--<asp:Button cssClass="btn btn-default btn-sm" ID="EditButton" runat="server" Text="Edit" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="EditButton_Click" ToolTip="Edit this order"  TabIndex="801"/>
            <asp:Button cssClass="btn btn-default btn-sm" ID="PrintButton" runat="server" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="PrintButton_Click" Text="LCS" toolTip="Print Load Confirmation Sheet"  TabIndex="802"/>
            <asp:Button cssClass="btn btn-default btn-sm" ID="PrintBOLButton" runat="server" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="PrintButton_Click" Text="BOL" toolTip="Print Bill of Lading" TabIndex="803"/>
        <asp:Button cssClass="btn btn-default btn-sm" ID="DuplicateButton" runat="server" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="DuplicateButton_Click" Text="Copy" ToolTip="Make a copy of this order with a status of Pending"  TabIndex="804"/>
        --%>
        
        
        
       <%-- <ul class="nav nav-pills">
            
        <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Options</a>
    <div class="dropdown-menu">
    

        <asp:LinkButton cssClass="dropdown-item" ID="EditButton" runat="server" Text="Edit" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="EditButton_Click" ToolTip="Edit this order"  TabIndex="801"/>
            <asp:LinkButton cssClass="dropdown-item" ID="PrintButton" runat="server" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="PrintButton_Click" Text="LCS" toolTip="Print Load Confirmation Sheet"  TabIndex="802"/>
            <asp:LinkButton cssClass="dropdown-item" ID="PrintBOLButton" runat="server" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="PrintButton_Click" Text="BOL" toolTip="Print Bill of Lading" TabIndex="803"/>
        <asp:LinkButton cssClass="dropdown-item" ID="DuplicateButton" runat="server" CommandArgument='<%# Eval("ShippingOrderID") %>' onclick="DuplicateButton_Click" Text="Copy" ToolTip="Make a copy of this order with a status of Pending"  TabIndex="804"/>
        
    </div>
  </li>
        
        </ul>--%>


            <div>

            <ul class="nav nav-pills flex-column">
 
  <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Options</a>
    <div class="dropdown-menu">
      <asp:LinkButton cssClass="dropdown-item" ID="EditButton" runat="server" Text="Edit" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="EditButton_Click" ToolTip="Edit this order"  TabIndex="801"/>
<%--            <asp:LinkButton cssClass="dropdown-item" ID="PrintButton" runat="server" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="PrintButton_Click" Text="LCS" toolTip="Print Load Confirmation Sheet"  TabIndex="802"/>
            <asp:LinkButton cssClass="dropdown-item" ID="PrintBOLButton" runat="server" CommandArgument='<%# Eval("ShippingOrderID") %>' OnClick="PrintButton_Click" Text="BOL" toolTip="Print Bill of Lading" TabIndex="803"/--%>>
           <a class="dropdown-item" href="#" onclick="window.open('POrequest.ashx?soid=<%# Eval("ShippingOrderID") %>'); return false;" title="Print PO Request">POR</a>
           <a class="dropdown-item" href="#" onclick="window.open('BOL.ashx?soid=<%# Eval("ShippingOrderID") %>'); return false;" title="Print Bill of Lading">BOL</a>
           <a class="dropdown-item" href="#" onclick="window.open('LCS.ashx?soid=<%# Eval("ShippingOrderID") %>'); return false;" title="Print Load Confirmation Sheet">LCS</a>
        <asp:LinkButton cssClass="dropdown-item" ID="DuplicateButton" runat="server" CommandArgument='<%# Eval("ShippingOrderID") %>' onclick="DuplicateButton_Click" Text="Copy" ToolTip="Make a copy of this order with a status of Pending"  TabIndex="804"/>
      
    </div>
  </li>
  
</ul>
            </div>


        
        
        
        </ItemTemplate></asp:TemplateField>
    </Columns>
   
    <EmptyDataTemplate>
        There are no Orders matching the selected status.
    </EmptyDataTemplate>
</asp:GridView>

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
    ) AS Location4CompanyName, OrderNumber,a1ActivityType,a2ActivityType,a3ActivityType,a4ActivityType, OrderDate
    , Carrier.[CargoInsuranceEffectiveDate]
      ,Carrier.[CargoInsuranceExpirationDate]
      ,Carrier.[LiabilityInsuranceEffectiveDate]
      ,Carrier.[LiabilityInsuranceExpirationDate]
      ,Carrier.[MCNumber], isnull(ShippingOrder.Priority,'2') as Priority
FROM    Company AS Customer
    INNER JOIN ShippingOrder ON Customer.Id = ShippingOrder.CustomerCompanyID
    LEFT OUTER JOIN Company AS Carrier ON ShippingOrder.CarrierCompanyID = Carrier.Id
WHERE   (@OrderNumber is null and ((ShippingOrder.StatusType = @StatusType and @StatusType &lt;&gt; 'Assigned') or (@StatusType = 'Assigned' and OrderDate between @StartDate and @EndDate ))) or (@OrderNumber is not null and OrderNumber = @OrderNumber) or (@CarrierCompanyID is not null and CarrierCompanyID = @CarrierCompanyID)   order by OrderNumber">
    <SelectParameters>
        <asp:ControlParameter ControlID="OrderStatusDropDownList" Name="StatusType" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="StartDateTextBox" Name="StartDate" PropertyName="text" />
        <asp:ControlParameter ControlID="EndDateTextBox" Name="EndDate" PropertyName="text" />
        <asp:ControlParameter ControlID="OrderNumberTextBox" Name="OrderNumber" PropertyName="text" />
        <asp:ControlParameter ControlID="CarrierDropDownList" Name="CarrierCompanyID" PropertyName="SelectedValue" />
    </SelectParameters>
</asp:SqlDataSource>



    </ContentTemplate>
<%--    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="OrdersGridView" EventName="RowCommand" />
    </Triggers>--%>
</asp:UpdatePanel>

</asp:Content>