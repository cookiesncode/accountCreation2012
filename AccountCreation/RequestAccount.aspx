<%@ Page Title="Request Form" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="RequestAccount.aspx.cs" Inherits="AccountCreation.RequestAccount" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2>Request Form</h2>	
	<asp:Panel ID="_adResultsContainer" runat="server" Visible="false">
		<section class="row">
			<div class="col-sm-12">
				<asp:Label ID="_adResultsOutput" runat="server" Text="Please wait while we check for any existing account types."></asp:Label>
			</div>
		</section>
	</asp:Panel>

	<asp:FormView ID="_requestForm" runat="server" DataKeyNames="Edipi" 
	DataSourceID="_accountRequestEDS" DefaultMode="Insert" RenderOuterTable="False" Visible="false">		
		<InsertItemTemplate>
			<section class="row">
				<div class="form-group col-sm-2">
					<label for="_edipi">EDIPI:</label>
					<asp:TextBox ID="_edipi" CssClass="form-control" runat="server" Text='<%# Bind("Edipi") %>'  />
				</div>

				<div class="form-group col-sm-3">
					<label for="_lName">Last Name:</label>
					<asp:TextBox ID="_lName" CssClass="form-control" runat="server" Text='<%# Bind("LName") %>' />
				</div>

				<div class="form-group col-sm-3">
					<label for="_fName">First Name:</label>
					<asp:TextBox ID="_fName" CssClass="form-control" runat="server" Text='<%# Bind("FName") %>' />
				</div>
				
				<div class="form-group col-sm-1">
					<label for="_middleInitial">MI:</label>
					<asp:TextBox ID="_middleInitial" CssClass="form-control" runat="server" Text='<%# Bind("Mi") %>' />
				</div>

				<div class="form-group col-sm-3">
					<label for="_rank">Rank:</label>
					<asp:DropDownList ID="_rank" CssClass="form-control" runat="server" Text='<%# Bind("Rank") %>'>
						<asp:ListItem>SGT</asp:ListItem>
					</asp:DropDownList>
				</div>
			</section>

			<section class="row">			
				<div class="form-group col-sm-2">
					<label for="_bldgNum">Bldg. Number:</label>
					<asp:TextBox ID="_bldgNum" CssClass="form-control" runat="server" Text='<%# Bind("Bldg") %>' />
				</div>
				
				<div class="form-group col-sm-2">
					<label for="_roomNum">Room Number:</label>
					<asp:TextBox ID="_roomNum" CssClass="form-control" runat="server" Text='<%# Bind("Room") %>' />
				</div>
				
				<div class="form-group col-sm-2">
					<label for="_office">Office:</label>
					<asp:TextBox ID="_office" CssClass="form-control" runat="server" Text='<%# Bind("Office") %>' />
				</div>

				<div class="form-group col-sm-3">
					<label for="_email">AKO Email:</label>
					<asp:TextBox ID="_email" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' />
				</div>

				<div class="form-group col-sm-3">
					<label for="_phone">Phone Number:</label>
					<asp:TextBox ID="_phone" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' />
				</div>
			</section>

			<section class="row">
				<div class="form-group col-sm-3">
					<label for="_department">Department:</label>
					<asp:DropDownList ID="_department" CssClass="form-control" runat="server" Text='<%# Bind("Department") %>'>
						<asp:ListItem>default</asp:ListItem>
					</asp:DropDownList>
				</div>
					
				<div class="form-group col-sm-3">
					<label for="_org">Organization:</label>
					<asp:DropDownList ID="_org" CssClass="form-control" runat="server" Text='<%# Bind("Org") %>'>
						<asp:ListItem>default</asp:ListItem>
					</asp:DropDownList>
				</div>

				<div class="form-group col-sm-3">
					<label for="_branch">Branch:</label>
					<asp:DropDownList ID="_branch" CssClass="form-control" runat="server" Text='<%# Bind("Branch") %>'>
						<asp:ListItem>default</asp:ListItem>
					</asp:DropDownList>
				</div>
					
				<div class="form-group col-sm-3">
					<label for="_installation">Installation:</label>
					<asp:DropDownList ID="_installation" CssClass="form-control" runat="server" Text='<%# Bind("Installation") %>'>
						<asp:ListItem>default</asp:ListItem>
					</asp:DropDownList>
				</div>
			</section>
			<div>
				<asp:Button ID="_submitBtn" runat="server" Text="Submit" CommandName="Insert" CssClass="btn btn-default" />
				<asp:Button ID="_cancelBtn" runat="server" CommandName="Cancel" Text="Reset form" CausesValidation="False" CssClass="btn btn-default" />
			</div>
		</InsertItemTemplate>
	</asp:FormView>
								
	<asp:EntityDataSource ID="_accountRequestEDS" runat="server" ConnectionString="name=CarsonAccountEntities" DefaultContainerName="CarsonAccountEntities" EnableFlattening="False" EnableInsert="True" EnableUpdate="True" EntitySetName="AccountRequests"></asp:EntityDataSource>

</asp:Content>

<asp:Content ID="_childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
