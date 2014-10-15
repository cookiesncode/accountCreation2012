<%@ Page Title="App Settings" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="settings.aspx.cs" Inherits="AccountCreation.settings" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="_settingsHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_settingsContent" ContentPlaceHolderID="_masterMainContent" runat="server">

	<h2 class="page-header">Settings</h2>

    <div class="row">
        <div class="col-sm-3">
            <asp:ListView 
                ID="_unitListView" 
                runat="server"
                DataSourceID="_unitSqlDataSource"
                DataKeyNames="Id"
                ItemPlaceholderID="_itemPlaceholder" 
                InsertItemPosition="LastItem">
                <LayoutTemplate>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3>Unit/Org.</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-condensed table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col"><asp:LinkButton ID="_sortButton" runat="server" CommandArgument="UnitName" CommandName="Sort">Unit/Org. Name</asp:LinkButton></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder ID="_itemPlaceholder" runat="server"></asp:PlaceHolder>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </LayoutTemplate>
        
                <ItemTemplate>
                    <tr>
                        <td>
                            <strong><asp:LinkButton ID="_deleteButton" runat="server" CommandName="Delete" Text="Delete" /></strong>
                            <asp:LinkButton ID="_editButton" runat="server" CommandName="Edit" Text="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="_unitName" runat="server" Text='<%# Eval("UnitName") %>' />
                        </td>
                    </tr>
                </ItemTemplate>

                <EditItemTemplate>
                    <tr>
                        <td>
                            <asp:LinkButton ID="_updateButton" runat="server" CommandName="Update" Text="Update" />
                            <asp:LinkButton ID="_cancelUpdateButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                        <td>
                            <asp:TextBox ID="_unitNameEdit" CssClass="form-control" runat="server" Text='<%# Bind("UnitName") %>' />
                        </td>
                    </tr>
                </EditItemTemplate>

                <InsertItemTemplate>
                    <tfoot>
                        <tr>
                            <td>
                                <strong><asp:LinkButton ID="_insertButton" runat="server" CommandName="Insert" Text="Insert" /></strong>
                                <asp:LinkButton ID="_cancelInsertButton" runat="server" CommandName="Cancel" Text="Clear" />
                            </td>
                            <td>
                                <asp:TextBox CssClass="form-control" ID="_unitNameInsert" runat="server" Text='<%# Bind("UnitName") %>' />
                            </td>
                        </tr>
                    </tfoot>
                </InsertItemTemplate>

                <EmptyDataTemplate>
                    <tr>
                        <td><strong>No data was returned.</strong></td>
                    </tr>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
        
        <div class="col-sm-3">
            <asp:ListView 
                ID="_rankListView" 
                runat="server"
                DataSourceID="_rankSqlDataSource"
                DataKeyNames="Id"
                ItemPlaceholderID="_itemPlaceholder" 
                InsertItemPosition="LastItem">
                <LayoutTemplate>
                    <div class="panel panel-default buffer hidden-print">
                        <div class="panel-heading">
                            <h3>Rank</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-condensed table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col"><asp:LinkButton ID="_sortButton" runat="server" CommandArgument="RankName" CommandName="Sort">Rank Name</asp:LinkButton></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder ID="_itemPlaceholder" runat="server"></asp:PlaceHolder>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </LayoutTemplate>
        
                <ItemTemplate>
                    <tr>
                        <td>
                            <strong><asp:LinkButton ID="_deleteButton" runat="server" CommandName="Delete" Text="Delete" /></strong>
                            <asp:LinkButton ID="_editButton" runat="server" CommandName="Edit" Text="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="_rankName" runat="server" Text='<%# Eval("RankName") %>' />
                        </td>
                    </tr>
                </ItemTemplate>

                <EditItemTemplate>
                    <tr>
                        <td>
                            <asp:LinkButton ID="_updateButton" runat="server" CommandName="Update" Text="Update" />
                            <asp:LinkButton ID="_cancelUpdateButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                        <td>
                            <asp:TextBox ID="_rankNameEdit" CssClass="form-control" runat="server" Text='<%# Bind("RankName") %>' />
                        </td>
                    </tr>
                </EditItemTemplate>

                <InsertItemTemplate>
                    <tfoot>
                        <tr>
                            <td>
                                <strong><asp:LinkButton ID="_insertButton" runat="server" CommandName="Insert" Text="Insert" /></strong>
                                <asp:LinkButton ID="_cancelInsertButton" runat="server" CommandName="Cancel" Text="Clear" />
                            </td>
                            <td>
                                <asp:TextBox ID="_rankNameInsert" CssClass="form-control" runat="server" Text='<%# Bind("RankName") %>' />
                            </td>
                        </tr>
                    </tfoot>
                </InsertItemTemplate>

                <EmptyDataTemplate>
                    <tr>
                        <td><strong>No data was returned.</strong></td>
                    </tr>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
    
        <div class="col-sm-3">
            <asp:ListView 
                ID="_personaListView" 
                runat="server"
                DataSourceID="_personaSqlDataSource"
                DataKeyNames="Id"
                ItemPlaceholderID="_itemPlaceholder" 
                InsertItemPosition="LastItem">
                <LayoutTemplate>
                    <div class="panel panel-default buffer hidden-print">
                        <div class="panel-heading">
                            <h3>Persona</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-condensed table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col"><asp:LinkButton ID="_sortButton" runat="server" CommandArgument="PersonaName" CommandName="Sort">Persona Name</asp:LinkButton></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder ID="_itemPlaceholder" runat="server"></asp:PlaceHolder>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </LayoutTemplate>
        
                <ItemTemplate>
                    <tr>
                        <td>
                            <strong><asp:LinkButton ID="_deleteButton" runat="server" CommandName="Delete" Text="Delete" /></strong>
                            <asp:LinkButton ID="_editButton" runat="server" CommandName="Edit" Text="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="_personaName" runat="server" Text='<%# Eval("PersonaName") %>' />
                        </td>
                    </tr>
                </ItemTemplate>

                <EditItemTemplate>
                    <tr>
                        <td>
                            <asp:LinkButton ID="_updateButton" runat="server" CommandName="Update" Text="Update" />
                            <asp:LinkButton ID="_cancelUpdateButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                        <td>
                            <asp:TextBox ID="_personaNameEdit" CssClass="form-control" runat="server" Text='<%# Bind("PersonaName") %>' />
                        </td>
                    </tr>
                </EditItemTemplate>

                <InsertItemTemplate>
                    <tfoot>
                        <tr>
                            <td>
                                <strong><asp:LinkButton ID="_insertButton" runat="server" CommandName="Insert" Text="Insert" /></strong>
                                <asp:LinkButton ID="_cancelInsertButton" runat="server" CommandName="Cancel" Text="Clear" />
                            </td>
                            <td>
                                <asp:TextBox ID="_personaNameInsert" CssClass="form-control" runat="server" Text='<%# Bind("PersonaName") %>' />
                            </td>
                        </tr>
                    </tfoot>
                </InsertItemTemplate>

                <EmptyDataTemplate>
                    <tr>
                        <td><strong>No data was returned.</strong></td>
                    </tr>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>

        <div class="col-sm-3">
            <asp:ListView 
                ID="_branchListView" 
                runat="server"
                DataSourceID="_branchSqlDataSource"
                DataKeyNames="Id"
                ItemPlaceholderID="_itemPlaceholder" 
                InsertItemPosition="LastItem">
                <LayoutTemplate>
                    <div class="panel panel-default buffer hidden-print">
                        <div class="panel-heading">
                            <h3>Branch</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-condensed table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col"><asp:LinkButton ID="_sortButton" runat="server" CommandArgument="BranchName" CommandName="Sort">Branch Name</asp:LinkButton></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder ID="_itemPlaceholder" runat="server"></asp:PlaceHolder>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </LayoutTemplate>
        
                <ItemTemplate>
                    <tr>
                        <td>
                            <strong><asp:LinkButton ID="_deleteButton" runat="server" CommandName="Delete" Text="Delete" /></strong>
                            <asp:LinkButton ID="_editButton" runat="server" CommandName="Edit" Text="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="_branchName" runat="server" Text='<%# Eval("BranchName") %>' />
                        </td>
                    </tr>
                </ItemTemplate>

                <EditItemTemplate>
                    <tr>
                        <td>
                            <asp:LinkButton ID="_updateButton" runat="server" CommandName="Update" Text="Update" />
                            <asp:LinkButton ID="_cancelUpdateButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                        <td>
                            <asp:TextBox ID="_branchNameEdit" CssClass="form-control" runat="server" Text='<%# Bind("BranchName") %>' />
                        </td>
                    </tr>
                </EditItemTemplate>

                <InsertItemTemplate>
                    <tfoot>
                        <tr>
                            <td>
                                <strong><asp:LinkButton ID="_insertButton" runat="server" CommandName="Insert" Text="Insert" /></strong>
                                <asp:LinkButton ID="_cancelInsertButton" runat="server" CommandName="Cancel" Text="Clear" />
                            </td>
                            <td>
                                <asp:TextBox ID="_branchNameInsert" CssClass="form-control" runat="server" Text='<%# Bind("BranchName") %>' />
                            </td>
                        </tr>
                    </tfoot>
                </InsertItemTemplate>

                <EmptyDataTemplate>
                    <tr>
                        <td><strong>No data was returned.</strong></td>
                    </tr>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
    </div>
    <asp:SqlDataSource 
        ID="_unitSqlDataSource" 
        runat="server" 
        ConnectionString='<%$ ConnectionStrings:localDatabase %>' 
        DeleteCommand="DELETE FROM [UnitOrg] WHERE [Id] = @Id" 
        InsertCommand="INSERT INTO [UnitOrg] ([UnitName]) VALUES (@UnitName)" 
        ProviderName='<%$ ConnectionStrings:localDatabase.ProviderName %>' 
        SelectCommand="SELECT * FROM [UnitOrg]" 
        UpdateCommand="UPDATE [UnitOrg] SET [UnitName] = @UnitName WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="UnitName" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UnitName" Type="String"></asp:Parameter>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="_personaSqlDataSource" runat="server" ConnectionString='<%$ ConnectionStrings:localDatabase %>' DeleteCommand="DELETE FROM [Persona] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Persona] ([PersonaName]) VALUES (@PersonaName)" ProviderName='<%$ ConnectionStrings:localDatabase.ProviderName %>' SelectCommand="SELECT * FROM [Persona]" UpdateCommand="UPDATE [Persona] SET [PersonaName] = @PersonaName WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PersonaName" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="PersonaName" Type="String"></asp:Parameter>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="_rankSqlDataSource" runat="server" ConnectionString='<%$ ConnectionStrings:localDatabase %>' DeleteCommand="DELETE FROM [Rank] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Rank] ([RankName]) VALUES (@RankName)" ProviderName='<%$ ConnectionStrings:localDatabase.ProviderName %>' SelectCommand="SELECT * FROM [Rank]" UpdateCommand="UPDATE [Rank] SET [RankName] = @RankName WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="RankName" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="RankName" Type="String"></asp:Parameter>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="_branchSqlDataSource" runat="server" ConnectionString='<%$ ConnectionStrings:localDatabase %>' DeleteCommand="DELETE FROM [Branch] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Branch] ([BranchName]) VALUES (@BranchName)" ProviderName='<%$ ConnectionStrings:localDatabase.ProviderName %>' SelectCommand="SELECT * FROM [Branch]" UpdateCommand="UPDATE [Branch] SET [BranchName] = @BranchName WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="BranchName" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="BranchName" Type="String"></asp:Parameter>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

<asp:Content ID="_settingsBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
