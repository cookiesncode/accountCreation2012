<%@ Page Title="Request Verification" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Verification.aspx.cs" Inherits="AccountCreation.Verification" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2 class="page-header">Request Verification</h2>
	<p>Please verify this information is correct.</p>
	<asp:Panel ID="_searchPanel" DefaultButton="_searchButton" runat="server">
		<div class="form-group">
			<label for="_searchEdipi" class="col-sm-2 control-label">Search by EDIPI:</label>
			<div class="col-sm-3">
				<asp:TextBox CssClass="form-control" ID="_searchEdipi" runat="server"></asp:TextBox>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<asp:Button ID="_searchButton" CausesValidation="false" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="_searchButton_Click" />
			</div>
		</div>
	</asp:Panel>
	<asp:FormView ID="_verifyForm" runat="server" 
		RenderOuterTable="False" 
		DataKeyNames="Edipi" 
		DataSourceID="_verifyEDS" 
		OnDataBound="_rank_DataBound">
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
					<asp:DropDownList ID="_Rank" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Rank") %>' DataSourceID="_verifyEDS" DataTextField="Rank" DataValueField="Rank">
						<asp:ListItem Text="-- Select Rank --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
	
			<div class="form-group">
				<label for="_branch" class="col-sm-2 control-label">Branch:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_branch" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Branch") %>' DataSourceID="_verifyEDS" DataTextField="Branch" DataValueField="Branch">
						<asp:ListItem Text="-- Select Branch --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
		
			<div class="form-group">
				<label for="_org" class="col-sm-2 control-label">Organization:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_org" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Org") %>' DataSourceID="_verifyEDS" DataTextField="Org" DataValueField="Org">
						<asp:ListItem Text="-- Select Organization --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
					
			<div class="form-group">
				<label for="_department" class="col-sm-2 control-label">Department:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_department" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Department") %>' DataSourceID="_verifyEDS" DataTextField="Department" DataValueField="Department">
						<asp:ListItem Text="-- Select Department --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
					
			<div class="form-group">
				<label for="_installation" class="col-sm-2 control-label">Installation:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_installation" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Installation") %>' DataSourceID="_verifyEDS" DataTextField="Installation" DataValueField="Installation">
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
				<div class="col-sm-offset-2 col-sm-10">
					<asp:Button ID="_updateButton" CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
					<asp:Button ID="_updateCancelButton" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
				</div>
			</div>
		</EditItemTemplate>
		<EmptyDataTemplate>
			<p>No records have been found.</p>
		</EmptyDataTemplate>
		<ItemTemplate>			
			<div class="form-group">
				<label for="_edipi" class="col-sm-2 control-label">EDIPI:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_edipi" runat="server" Text='<%# Bind("Edipi") %>'  />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_lName" class="col-sm-2 control-label">Last Name:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_lName" runat="server" Text='<%# Bind("LName") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_fName" class="col-sm-2 control-label">First Name:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_fName" runat="server" Text='<%# Bind("FName") %>' />
					</p>
				</div>
			</div>
				
			<div class="form-group">
				<label for="_middleInitial" class="col-sm-2 control-label">MI:</label>
				<div class="col-sm-1">
					<p class="form-control-static">
						<asp:Literal ID="_middleInitial" runat="server" Text='<%# Bind("Mi") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_email" class="col-sm-2 control-label">AKO Email:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_email" runat="server" Text='<%# Bind("Email") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_rank" class="col-sm-2 control-label">Rank:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_rank" runat="server" Text='<%# Bind("Rank") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_branch" class="col-sm-2 control-label">Branch:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_branch" runat="server" Text='<%# Bind("Branch") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_org" class="col-sm-2 control-label">Organization:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_org" runat="server" Text='<%# Bind("Org") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_department" class="col-sm-2 control-label">Department:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_department" runat="server" Text='<%# Bind("Department") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_installation" class="col-sm-2 control-label">Installation:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_installation" runat="server" Text='<%# Bind("Installation") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_bldgNum" class="col-sm-2 control-label">Bldg Number:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_bldgNum" runat="server" Text='<%# Bind("Bldg") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_roomNum" class="col-sm-2 control-label">Room Number:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_roomNum" runat="server" Text='<%# Bind("Room") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_office" class="col-sm-2 control-label">Office:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_office" runat="server" Text='<%# Bind("Office") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_phone" class="col-sm-2 control-label">Phone Number:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_phone" runat="server" Text='<%# Bind("Phone") %>' />
					</p>
				</div>
			</div>

			SupName:
			<asp:Label ID="SupNameLabel" runat="server" Text='<%# Bind("SupName") %>' />
			<br />
			SecName:
			<asp:Label ID="SecNameLabel" runat="server" Text='<%# Bind("SecName") %>' />
			<br />

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<asp:Button ID="_editButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-default" />
					<asp:Button ID="_deleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
				</div>
			</div>
		</ItemTemplate>
	</asp:FormView>

	<asp:EntityDataSource ID="_verifyEDS" runat="server" 
		ConnectionString="name=CarsonAccountEntities" 
		DefaultContainerName="CarsonAccountEntities" 
		EnableDelete="True" 
		EnableFlattening="False" 
		EnableUpdate="True" 
		EntitySetName="AccountRequests">
	</asp:EntityDataSource>

<%--	<asp:QueryExtender ID="_queryStringExtender" runat="server"
		TargetControlID="_verifyEDS">
		<asp:SearchExpression SearchType="Contains" DataFields="Edipi">
		</asp:SearchExpression>
	</asp:QueryExtender>--%>
	
	<asp:QueryExtender ID="_edipiQueryExtender" runat="server"
		TargetControlID="_verifyEDS">
		<asp:PropertyExpression>
			<asp:ControlParameter ControlID="_searchEdipi" Name="Edipi" ConvertEmptyStringToNull="true" />
		</asp:PropertyExpression>
	</asp:QueryExtender>
</asp:Content>

<asp:Content ID="_childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
