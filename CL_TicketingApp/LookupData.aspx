<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="LookupData.aspx.vb" Inherits="CL_TicketingApp.LookupData" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Lookup Data</h1>
    Choose a lookup category:&nbsp;<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="CategorySqlDataSource" DataTextField="category" DataValueField="category">
    </asp:DropDownList>
    <br />
    <br />

  <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="Id" DataSourceID="LookupSqlDataSource" ForeColor="Black" GridLines="Vertical" ShowFooter="True">
        <AlternatingRowStyle BackColor="#CCCCCC" />
        <Columns>
            <asp:TemplateField HeaderText="Id" InsertVisible="False" SortExpression="Id">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                </EditItemTemplate>
                <FooterTemplate>
                    [Auto]
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Category" SortExpression="Category">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Category") %>'></asp:TextBox>
                </EditItemTemplate>
<FooterTemplate>
    <asp:DropDownList ID="AddCategoryDropDownList" runat="server" AutoPostBack="True" DataSourceID="CategorySqlDataSource" DataTextField="category" DataValueField="category">
    </asp:DropDownList>

</FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Category") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Value" SortExpression="Value">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Value") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="ValueTextBox" runat="server" ></asp:TextBox>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Value") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="DisplayOrder" SortExpression="DisplayOrder">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("DisplayOrder") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("DisplayOrder") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate><asp:TextBox ID="DisplayOrderTextBox" runat="server" ></asp:TextBox></FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:LinkButton ID="InsertLinkButton" runat="server" CommandName="Insert">Add</asp:LinkButton>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                    
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#CCCCCC" />
        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
      <EmptyDataTemplate>
          There are no lookup values matching the chosen criteria.  Please choose a category from the dropdown list.
      </EmptyDataTemplate>
    </asp:GridView>

    <asp:SqlDataSource ID="LookupSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [l] WHERE [Id] = @Id" InsertCommand="INSERT INTO [l] ([Category], [Value], [DisplayOrder]) VALUES (@Category, @Value, @DisplayOrder)" SelectCommand="SELECT * FROM [l] WHERE ([Category] = @Category) ORDER BY [DisplayOrder], [Value]" UpdateCommand="UPDATE [l] SET [Category] = @Category, [Value] = @Value, [DisplayOrder] = @DisplayOrder WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id"  />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Category" Type="String" />
            <asp:Parameter Name="Value" Type="String" />
            <asp:Parameter Name="DisplayOrder"  />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Category" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Category" Type="String" />
            <asp:Parameter Name="Value" Type="String" />
            <asp:Parameter Name="DisplayOrder" Type="Int32" />
            <asp:Parameter Name="Id"  />
        </UpdateParameters>
    </asp:SqlDataSource>

    <br />
    &nbsp;<asp:SqlDataSource ID="CategorySqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="select distinct category from l order by category"></asp:SqlDataSource>
  
    <br />
    <br />
   
    </asp:Content>
