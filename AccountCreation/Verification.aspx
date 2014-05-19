<%@ Page Title="Request Verification" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Verification.aspx.cs" Inherits="AccountCreation.Verification" MaintainScrollPositionOnPostback="true" %>

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

	<asp:FormView ID="_verifyForm" runat="server"
		Visible="false" 
		RenderOuterTable="False" 
		DataKeyNames="Id" 
		DataSourceID="_verifyEDS" 
		OnDataBound="_verifyForm_DataBound"
		DefaultMode="Edit">
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
<%--		<ItemTemplate>			
			<div class="form-group">
				<label for="_edipi" class="col-sm-2 control-label">EDIPI:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_edipi" runat="server" Text='<%# Eval("Edipi") %>'  />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_lName" class="col-sm-2 control-label">Last Name:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_lName" runat="server" Text='<%# Eval("LName") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_fName" class="col-sm-2 control-label">First Name:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_fName" runat="server" Text='<%# Eval("FName") %>' />
					</p>
				</div>
			</div>
				
			<div class="form-group">
				<label for="_middleInitial" class="col-sm-2 control-label">MI:</label>
				<div class="col-sm-1">
					<p class="form-control-static">
						<asp:Literal ID="_middleInitial" runat="server" Text='<%# Eval("Mi") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_email" class="col-sm-2 control-label">AKO Email:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_email" runat="server" Text='<%# Eval("Email") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_rank" class="col-sm-2 control-label">Rank:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_rank" runat="server" Text='<%# Eval("Rank") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_branch" class="col-sm-2 control-label">Branch:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_branch" runat="server" Text='<%# Eval("Branch") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_org" class="col-sm-2 control-label">Organization:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_org" runat="server" Text='<%# Eval("Org") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_department" class="col-sm-2 control-label">Department:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_department" runat="server" Text='<%# Eval("Department") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_installation" class="col-sm-2 control-label">Installation:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_installation" runat="server" Text='<%# Eval("Installation") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_bldgNum" class="col-sm-2 control-label">Bldg Number:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_bldgNum" runat="server" Text='<%# Eval("Bldg") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_roomNum" class="col-sm-2 control-label">Room Number:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_roomNum" runat="server" Text='<%# Eval("Room") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_office" class="col-sm-2 control-label">Office:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_office" runat="server" Text='<%# Eval("Office") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_phone" class="col-sm-2 control-label">Phone Number:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_phone" runat="server" Text='<%# Eval("Phone") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_supSignature" class="col-sm-2 control-label">Supervisor's Edipi:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_supSignature" runat="server" Text='<%# Eval("SupEdipi") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<label for="_secSignature" class="col-sm-2 control-label">Security Manager's Edipi:</label>
				<div class="col-sm-3">
					<p class="form-control-static">
						<asp:Literal ID="_secSignature" runat="server" Text='<%# Eval("SecEdipi") %>' />
					</p>
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<asp:Button ID="_editButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Update and sign" CssClass="btn btn-default" />
					<asp:Button ID="_deleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
				</div>
			</div>
		</ItemTemplate>--%>
	</asp:FormView>

	<asp:EntityDataSource ID="_verifyEDS" runat="server" 
		ConnectionString="name=CarsonAccountEntities" 
		DefaultContainerName="CarsonAccountEntities" 
		EnableDelete="True" 
		EnableFlattening="False" 
		EnableUpdate="True" 
		EntitySetName="AccountRequests">
	</asp:EntityDataSource>
	
	<asp:QueryExtender ID="_searchQueryExtender" runat="server"
		TargetControlID="_verifyEDS">		
		<asp:SearchExpression DataFields="LName, FName, Edipi" SearchType="Contains">
			<asp:ControlParameter ControlID="_searchBox" />
		</asp:SearchExpression>
<%--		<asp:PropertyExpression>
			<asp:ControlParameter ControlID="_searchBox" Name="Id" />
		</asp:PropertyExpression>--%>

	</asp:QueryExtender>
</asp:Content>

<asp:Content ID="_childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
