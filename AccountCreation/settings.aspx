<%@ Page Title="Settings" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="settings.aspx.cs" Inherits="AccountCreation.settings" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="_settingsHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_settingsContent" ContentPlaceHolderID="_masterMainContent" runat="server">

	<h2 class="page-header">Settings</h2>

    <div class="well settings-section">
        <ul class="nav nav-tabs" role="tablist">
            <li id="_unitListItem" class="active" runat="server"><a href="#_unitTab" role="tab" data-toggle="tab">Unit List</a></li>
            <li id="_rankListItem" runat="server"><a href="#_rankTab" role="tab" data-toggle="tab">Rank List</a></li>
            <li id="_personaListItem" runat="server"><a href="#_personaTab" role="tab" data-toggle="tab">Persona List</a></li>
            <li id="_branchListItem" runat="server"><a href="#_branchTab" role="tab" data-toggle="tab">Branch List</a></li>
            <li id="_installationListItem" runat="server"><a href="#_installationTab" role="tab" data-toggle="tab">Installation List</a></li>
        </ul>

        <div class="row">
            <div class="col-sm-4">
                <div class="tab-content">
                    <asp:Panel ID="_unitTab" runat="server" CssClass="tab-pane fade in active" ClientIDMode="Static">     
                        <asp:ListView ID="_unitListView"
                            runat="server"
                            DataSourceID="_unitEntityDataSource"
                            DataKeyNames="Id"
                            ItemPlaceholderID="_itemPlaceholder" 
                            InsertItemPosition="LastItem" 
                            OnItemCommand="_listView_ItemCommand">
                            <LayoutTemplate>
                                <div class="panel panel-default">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th scope="col"></th>
                                                    <th scope="col"><asp:LinkButton ID="_sortButton" runat="server" CommandArgument="UnitName" CommandName="Sort">Unit/Organization</asp:LinkButton></th>
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
                    </asp:Panel>

                    <asp:Panel ID="_rankTab" runat="server" CssClass="tab-pane fade" ClientIDMode="Static">  
                        <asp:ListView ID="_rankListView" 
                            runat="server"
                            DataSourceID="_rankEntityDataSource"
                            DataKeyNames="Id"
                            ItemPlaceholderID="_itemPlaceholder" 
                            InsertItemPosition="LastItem"
                            OnItemCommand="_listView_ItemCommand">
                            <LayoutTemplate>
                                <div class="panel panel-default buffer hidden-print">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th scope="col"></th>
                                                    <th scope="col"><asp:LinkButton ID="_sortButton" runat="server" CommandArgument="RankName" CommandName="Sort">Rank</asp:LinkButton></th>
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
                    </asp:Panel>

                    <asp:Panel ID="_personaTab" runat="server" CssClass="tab-pane fade" ClientIDMode="Static">
                        <asp:ListView ID="_personaListView" 
                            runat="server"
                            DataSourceID="_personaEntityDataSource"
                            DataKeyNames="Id"
                            ItemPlaceholderID="_itemPlaceholder" 
                            InsertItemPosition="LastItem"
                            OnItemCommand="_listView_ItemCommand">
                            <LayoutTemplate>
                                <div class="panel panel-default buffer hidden-print">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th scope="col"></th>
                                                    <th scope="col"><asp:LinkButton ID="_sortButton" runat="server" CommandArgument="PersonaName" CommandName="Sort">Persona</asp:LinkButton></th>
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
                    </asp:Panel>

                    <asp:Panel ID="_branchTab" runat="server" CssClass="tab-pane fade" ClientIDMode="Static">
                        <asp:ListView ID="_branchListView" 
                            runat="server"
                            DataSourceID="_branchEntityDataSource"
                            DataKeyNames="Id"
                            ItemPlaceholderID="_itemPlaceholder" 
                            InsertItemPosition="LastItem"
                            OnItemCommand="_listView_ItemCommand">
                            <LayoutTemplate>
                                <div class="panel panel-default buffer hidden-print">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th scope="col"></th>
                                                    <th scope="col"><asp:LinkButton ID="_sortButton" runat="server" CommandArgument="BranchName" CommandName="Sort">Branch</asp:LinkButton></th>
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
                    </asp:Panel>

                    <asp:Panel ID="_installationTab" runat="server" CssClass="tab-pane fade" ClientIDMode="Static">
                        <asp:ListView ID="_installationListView" 
                            runat="server"
                            DataSourceID="_installationEntityDataSource"
                            DataKeyNames="Id"
                            ItemPlaceholderID="_itemPlaceholder" 
                            InsertItemPosition="LastItem"
                            OnItemCommand="_listView_ItemCommand">
                            <LayoutTemplate>
                                <div class="panel panel-default buffer hidden-print">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th scope="col"></th>
                                                    <th scope="col"><asp:LinkButton ID="_sortButton" runat="server" CommandArgument="InstallationName" CommandName="Sort">Installation</asp:LinkButton></th>
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
                                        <asp:Label ID="_installationName" runat="server" Text='<%# Eval("InstallationName") %>' />
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
                                        <asp:TextBox ID="_installationNameEdit" CssClass="form-control" runat="server" Text='<%# Bind("InstallationName") %>' />
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
                                            <asp:TextBox ID="_installationNameInsert" CssClass="form-control" runat="server" Text='<%# Bind("InstallationName") %>' />
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
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>

    <asp:EntityDataSource ID="_branchEntityDataSource" 
        runat="server" 
        ConnectionString="name=SettingEntities" 
        DefaultContainerName="SettingEntities" 
        EnableDelete="True" 
        EnableFlattening="False" 
        EnableInsert="True" 
        EnableUpdate="True" 
        EntitySetName="Branches">
    </asp:EntityDataSource>

    <asp:EntityDataSource ID="_unitEntityDataSource" 
        runat="server" 
        ConnectionString="name=SettingEntities" 
        DefaultContainerName="SettingEntities" 
        EnableDelete="True" 
        EnableFlattening="False" 
        EnableInsert="True" 
        EnableUpdate="True" 
        EntitySetName="UnitOrgs">
    </asp:EntityDataSource>

    <asp:EntityDataSource ID="_personaEntityDataSource" 
        runat="server" 
        ConnectionString="name=SettingEntities" 
        DefaultContainerName="SettingEntities" 
        EnableDelete="True" 
        EnableFlattening="False" 
        EnableInsert="True" 
        EnableUpdate="True" 
        EntitySetName="Personas">
    </asp:EntityDataSource>

    <asp:EntityDataSource ID="_rankEntityDataSource" 
        runat="server" 
        ConnectionString="name=SettingEntities" 
        DefaultContainerName="SettingEntities" 
        EnableDelete="True" 
        EnableFlattening="False" 
        EnableInsert="True" 
        EnableUpdate="True" 
        EntitySetName="Ranks">
    </asp:EntityDataSource>

    <asp:EntityDataSource ID="_installationEntityDataSource" 
        runat="server" 
        ConnectionString="name=SettingEntities" 
        DefaultContainerName="SettingEntities" 
        EnableDelete="True" 
        EnableFlattening="False" 
        EnableInsert="True" 
        EnableUpdate="True" 
        EntitySetName="Installations">
    </asp:EntityDataSource>

</asp:Content>

<asp:Content ID="_settingsBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
