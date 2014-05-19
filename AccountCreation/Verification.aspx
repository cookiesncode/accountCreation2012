﻿<%@ Page Title="Request Verification" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Verification.aspx.cs" Inherits="AccountCreation.Verification" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	
	<h2 class="page-header">Request Verification</h2>
	<asp:Panel ID="_searchPanel" DefaultButton="_searchButton" runat="server">
		<p>Please search by the EDIPI number, last name, or first name. <small>EDIPI is more efficient</small></p>
		<div class="form-group">
			<div class="col-sm-3 col-xs-4 col-md-3 col-lg-2">
				<asp:TextBox CssClass="form-control" ID="_searchBox" runat="server"></asp:TextBox>
			</div>
			<div class="col-sm-2 col-xs-4">
				<asp:Button ID="_searchButton" CausesValidation="false" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="_searchButton_Click" />
			</div>
		</div>
	</asp:Panel>
	<asp:GridView ID="_gridview" runat="server" DataKeyNames="Id" DataSourceID="_gridEntitySource" AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True" OnSelectedIndexChanged="_gridview_SelectedIndexChanged">
		<Columns>
			<asp:CommandField ShowSelectButton="True"></asp:CommandField>
			<asp:BoundField DataField="Edipi" HeaderText="Edipi" SortExpression="Edipi" />
			<asp:BoundField DataField="LName" HeaderText="LName" SortExpression="LName" />
			<asp:BoundField DataField="FName" HeaderText="FName" SortExpression="FName" />
			<asp:BoundField DataField="Mi" HeaderText="Mi" SortExpression="Mi" />
			<asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
			<asp:BoundField DataField="Rank" HeaderText="Rank" SortExpression="Rank" />
			<asp:BoundField DataField="Org" HeaderText="Org" SortExpression="Org" />
			<asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
			<asp:BoundField DataField="Installation" HeaderText="Installation" SortExpression="Installation" />
			<asp:BoundField DataField="Branch" HeaderText="Branch" SortExpression="Branch" />
			<asp:BoundField DataField="Bldg" HeaderText="Bldg" SortExpression="Bldg" />
			<asp:BoundField DataField="Room" HeaderText="Room" SortExpression="Room" />
			<asp:BoundField DataField="Office" HeaderText="Office" SortExpression="Office" />
			<asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
			<asp:BoundField DataField="SupEdipi" HeaderText="Supervisor's Signature" SortExpression="SupEdipi" />
			<asp:BoundField DataField="SecEdipi" HeaderText="Security Manager's" SortExpression="SecEdipi" />
		</Columns>
	</asp:GridView>
	<asp:FormView ID="_formview" runat="server"
		RenderOuterTable="False"
		DataKeyNames="Id"
		DataSourceID="_formviewEntitySource"
		OnDataBound="_formview_DataBound"
		DefaultMode="Edit"
		Visible="false">
		<EditItemTemplate>
			<div class="form-group">
				<label for="_edipi" class="col-sm-2 control-label">EDIPI:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_edipi"  Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("Edipi") %>'  /></div>
			</div>

			<div class="form-group">
				<label for="_lName" class="col-sm-2 control-label">Last Name:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_lName" CssClass="form-control" Enabled="false" runat="server" Text='<%# Bind("LName") %>' />

				</div>
			</div>

			<div class="form-group">
				<label for="_fName" class="col-sm-2 control-label">First Name:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_fName" CssClass="form-control" Enabled="false" runat="server" Text='<%# Bind("FName") %>' />
				</div>
			</div>
				
			<div class="form-group">
				<label for="_middleInitial" class="col-sm-2 control-label">MI:</label>
				<div class="col-sm-1">
					<asp:TextBox ID="_middleInitial" CssClass="form-control" runat="server" Text='<%# Bind("Mi") %>' />
				</div>
			</div>

			<div class="form-group">
				<label for="_email" class="col-sm-2 control-label">AKO Email:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_email" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' />
				</div>
			</div>

			<div class="form-group">
				<label for="_rank" class="col-sm-2 control-label">Rank:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_Rank" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Rank") %>' DataSourceID="_formviewEntitySource" DataTextField="Rank" DataValueField="Rank">
						<asp:ListItem Text="-- Select Rank --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
	
			<div class="form-group">
				<label for="_branch" class="col-sm-2 control-label">Branch:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_branch" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Branch") %>' DataSourceID="_formviewEntitySource" DataTextField="Branch" DataValueField="Branch">
						<asp:ListItem Text="-- Select Branch --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
		
			<div class="form-group">
				<label for="_org" class="col-sm-2 control-label">Organization:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_org" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Org") %>' DataSourceID="_formviewEntitySource" DataTextField="Org" DataValueField="Org">
						<asp:ListItem Text="-- Select Organization --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
					
			<div class="form-group">
				<label for="_department" class="col-sm-2 control-label">Department:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_department" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Department") %>' DataSourceID="_formviewEntitySource" DataTextField="Department" DataValueField="Department">
						<asp:ListItem Text="-- Select Department --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
					
			<div class="form-group">
				<label for="_installation" class="col-sm-2 control-label">Installation:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_installation" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Installation") %>' DataSourceID="_formviewEntitySource" DataTextField="Installation" DataValueField="Installation">
						<asp:ListItem Text="-- Select Installation --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
		
			<div class="form-group">
				<label for="_bldgNum" class="col-sm-2 control-label">Bldg. Number:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_bldgNum" CssClass="form-control" runat="server" Text='<%# Bind("Bldg") %>' />
				</div>
			</div>
				
			<div class="form-group">
				<label for="_roomNum" class="col-sm-2 control-label">Room Number:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_roomNum" CssClass="form-control" runat="server" Text='<%# Bind("Room") %>' />
				</div>
			</div>
				
			<div class="form-group">
				<label for="_office" class="col-sm-2 control-label">Office:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_office" CssClass="form-control" runat="server" Text='<%# Bind("Office") %>' />
				</div>
			</div>

			<div class="form-group">
				<label for="_phone" class="col-sm-2 control-label">Phone Number:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_phone" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' />
				</div>
			</div>

			<div class="form-group">
				<label for="_supervisorCheckBox" class="col-sm-2 control-label">Supervisor:</label>
				<div class="col-sm-4">
					<div class="input-group">
						<span class="input-group-addon">
							<asp:CheckBox ID="_supervisorCheckBox" runat="server" OnCheckedChanged="_CheckBox_CheckedChanged" AutoPostBack="True" />
						</span>
						<asp:TextBox ID="_supervisorSignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("SupEdipi") %>' />
					</div>
				</div>
				<label for="_securityCheckBox" class="col-sm-2 control-label">Security Manager:</label>
				<div class="col-sm-4">
					<div class="input-group">
						<span class="input-group-addon">
							<asp:CheckBox ID="_securityCheckBox" OnCheckedChanged="_CheckBox_CheckedChanged"  runat="server" AutoPostBack="True" />
						</span>
						<asp:TextBox ID="_securitySignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("SecEdipi") %>' />
					</div>
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<asp:Button ID="_updateButton" CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Update" Text="Update request" />
					<asp:Button ID="_updateCancelButton" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
				</div>
			</div>
		</EditItemTemplate>
		<EmptyDataTemplate>
			<p>No records have been found.</p>
		</EmptyDataTemplate>
	</asp:FormView>

	<asp:EntityDataSource ID="_gridEntitySource" runat="server" 
		ConnectionString="name=CarsonAccountEntities" 
		DefaultContainerName="CarsonAccountEntities" 
		EnableDelete="True" 
		EnableFlattening="False" 
		EnableUpdate="True" 
		EntitySetName="AccountRequests">
	</asp:EntityDataSource>
	
	<asp:QueryExtender ID="_searchQueryExtender" runat="server"
		TargetControlID="_gridEntitySource">		
		<asp:SearchExpression DataFields="LName, FName, Edipi" SearchType="Contains">
			<asp:ControlParameter ControlID="_searchBox" />
		</asp:SearchExpression>
	</asp:QueryExtender>
	
	<asp:EntityDataSource ID="_formviewEntitySource" runat="server" 
		ConnectionString="name=CarsonAccountEntities" 
		DefaultContainerName="CarsonAccountEntities" 
		EnableDelete="True" 
		EnableFlattening="False" 
		EnableUpdate="True" 
		EntitySetName="AccountRequests">
	</asp:EntityDataSource>
	
	<asp:QueryExtender ID="_filterQueryExtender" runat="server"
		TargetControlID="_formviewEntitySource">
		<asp:PropertyExpression>
			<asp:ControlParameter ControlID="_gridview" Name="Id" PropertyName="SelectedDataKey.Value"/>
		</asp:PropertyExpression>	
	</asp:QueryExtender>
</asp:Content>

<asp:Content ID="_childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
