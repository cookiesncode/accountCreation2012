<%@ Page Title="Request Form" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="RequestAccount.aspx.cs" Inherits="AccountCreation.RequestAccount"  %>
<%@ PreviousPageType VirtualPath="~/RequestType.aspx" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2 class="page-header">Request Form</h2>	
	<asp:Panel ID="_niprResults" runat="server" Visible="false">
		<p>Our records indicate that you already have a NIPR account. The account display name is <strong><asp:Label ID="_niprName" runat="server" CssClass="text-warning"></asp:Label></strong>.</p>
	</asp:Panel>

	<asp:Panel ID="_vpnResults" runat="server" Visible="false">
		<p>Our records indicate that you already have a VPN account. The name of the VPN group you reside in is <strong><asp:Label ID="_vpnGroup" runat="server" CssClass="text-warning"></asp:Label></strong></p>
	</asp:Panel>

	<asp:Panel ID="_redirectMessage" runat="server" Visible="false">
		<p>If you feel this is incorrect then please... or go to the <a href="RequestType.aspx" class="btn btn-primary btn-xs">Request Type</a> page and try again.</p>
	</asp:Panel>

	<asp:FormView ID="_requestForm" runat="server" DataKeyNames="Id"
		DataSourceID="_accountRequestEDS" DefaultMode="Insert" RenderOuterTable="False" OnDataBound="_requestForm_DataBound">		
		<InsertItemTemplate>
			<p>Please fill out your information.</p>
			<div class="form-group">
				<label for="_edipi" class="col-sm-2 control-label">EDIPI:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_edipi" CssClass="form-control" runat="server" Text='<%# Bind("Edipi") %>'  /></div>
			</div>

			<div class="form-group">
				<label for="_lName" class="col-sm-2 control-label">Last Name:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_lName" CssClass="form-control" runat="server" Text='<%# Bind("LName") %>' />

				</div>
			</div>

			<div class="form-group">
				<label for="_fName" class="col-sm-2 control-label">First Name:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_fName" CssClass="form-control" runat="server" Text='<%# Bind("FName") %>' />
				</div>
			</div>
				
			<div class="form-group">
				<label for="_middleInitial" class="col-sm-2 control-label">MI:</label>
				<div class="col-sm-1">
					<asp:TextBox ID="_middleInitial" CssClass="form-control" runat="server" Text='<%# Bind("Mi") %>' />
				</div>
			</div>

			<div class="form-group">
				<label for="_rank" class="col-sm-2 control-label">Rank:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_rank" CssClass="form-control" runat="server" Text='<%# Bind("Rank") %>' AppendDataBoundItems="true">
						<asp:ListItem Text="-- Select Rank --" Value="" />
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
				<label for="_email" class="col-sm-2 control-label">AKO Email:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_email" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' />
				</div>
			</div>

			<div class="form-group">
				<label for="_phone" class="col-sm-2 control-label">Phone Number:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_phone" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' />
				</div>
			</div>

			<div class="form-group">
				<label for="_department" class="col-sm-2 control-label">Department:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_department" CssClass="form-control" runat="server" Text='<%# Bind("Department") %>'>
						<asp:ListItem Text="-- Select Department --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
					
<%--			<div class="form-group">
				<label for="_org" class="col-sm-2 control-label">Organization:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_org" CssClass="form-control" AppendDataBoundItems="true" runat="server" Text='<%# Bind("Org") %>'>
						<asp:ListItem Text="-- Select Organization --" Value="" />
					</asp:DropDownList>
				</div>
			</div>--%>

			<div class="form-group">
				<label for="_branch" class="col-sm-2 control-label">Branch:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_branch" CssClass="form-control" runat="server" Text='<%# Bind("Branch") %>'>
						<asp:ListItem Text="-- Select Branch --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
					
<%--			<div class="form-group">
				<label for="_installation" class="col-sm-2 control-label">Installation:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_installation" CssClass="form-control" runat="server" Text='<%# Bind("Installation") %>'>
						<asp:ListItem Text="-- Select Installation --" Value="" />
					</asp:DropDownList>
				</div>
			</div>--%>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<asp:Button ID="_submitBtn" runat="server" Text="Submit" CommandName="Insert" CssClass="btn btn-primary" OnClick="_submitBtn_Click" />
					<asp:Button ID="_cancelBtn" runat="server" CommandName="Cancel" Text="Reset form" CausesValidation="False" CssClass="btn btn-default" />
				</div>
			</div>
		</InsertItemTemplate>
	</asp:FormView>
								
	<asp:EntityDataSource ID="_accountRequestEDS" runat="server" ConnectionString="name=CarsonAccountEntities" DefaultContainerName="CarsonAccountEntities" EnableFlattening="False" EnableInsert="True" EnableUpdate="True" EntitySetName="AccountRequests"></asp:EntityDataSource>

</asp:Content>

<asp:Content ID="_childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
