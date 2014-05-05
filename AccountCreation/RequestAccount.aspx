<%@ Page Title="Request Form" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="RequestAccount.aspx.cs" Inherits="AccountCreation.RequestAccount" %>

<asp:Content ID="childHead" ContentPlaceHolderID="masterHead" runat="server">
</asp:Content>

<asp:Content ID="childMainContent" ContentPlaceHolderID="masterMainContent" runat="server">
	<h2>Request Form</h2>
	<asp:Panel ID="uiAdCheckContainer" runat="server">
		<p class="lead">What type of account are you requesting?</p>
		<section class="row">		
			<div class="form-group col-sm-1">
				<asp:CheckBox ID="uiNiprAcct" runat="server" />
				<label for="uiNiprAcct">NIPR</label>
			</div>
			<div class="form-group col-sm-1">
				<asp:CheckBox ID="uiSaAcct" runat="server" />
				<label for="uiSaAcct">SIPR</label>
			</div>
			<div class="form-group col-sm-1">
				<asp:CheckBox ID="uiEpAcct" runat="server" />
				<label for="uiEpAcct">EP</label>
			</div>
			<div class="form-group col-sm-1">
				<asp:CheckBox ID="uiVpnAcct" runat="server" />
				<label for="uiVpnAcct">VPN</label>
			</div>
		</section>
		<asp:Button ID="uiAcctCheckBtn" runat="server" Text="Submit" CssClass="btn btn-default" OnClick="uiAcctCheckBtn_Click" />		
	</asp:Panel>
	
	<asp:Panel ID="uiAdResultsContainer" runat="server" Visible="false">
		<section class="row">
			<div class="col-sm-12">
				<asp:Label ID="uiAdResultsOutput" runat="server" Text="Please wait while we check for any existing account types."></asp:Label>
			</div>
		</section>
	</asp:Panel>

	<asp:FormView ID="uiAccountRequestForm" runat="server" DataKeyNames="Edipi" 
	DataSourceID="uiAccountRequestEDS" DefaultMode="Insert" RenderOuterTable="False" Visible="false">		
		<InsertItemTemplate>
			<section class="row">
				<div class="form-group col-sm-2">
					<label for="uiEdipi">EDIPI:</label>
					<asp:TextBox ID="uiEdipi" CssClass="form-control" runat="server" Text='<%# Bind("Edipi") %>'  />
				</div>

				<div class="form-group col-sm-3">
					<label for="uiLname">Last Name:</label>
					<asp:TextBox ID="uiLname" CssClass="form-control" runat="server" Text='<%# Bind("LName") %>' />
				</div>

				<div class="form-group col-sm-3">
					<label for="uiFname">First Name:</label>
					<asp:TextBox ID="uiFname" CssClass="form-control" runat="server" Text='<%# Bind("FName") %>' />
				</div>
				
				<div class="form-group col-sm-1">
					<label for="uiMiddleInitial">MI:</label>
					<asp:TextBox ID="uiMiddleInitial" CssClass="form-control" runat="server" Text='<%# Bind("Mi") %>' />
				</div>

				<div class="form-group col-sm-3">
					<label for="uiRank">Rank:</label>
					<asp:DropDownList ID="uiRank" CssClass="form-control" runat="server" Text='<%# Bind("Rank") %>'>
						<asp:ListItem>SGT</asp:ListItem>
					</asp:DropDownList>
				</div>
			</section>

			<section class="row">			
				<div class="form-group col-sm-2">
					<label for="uiBldgNum">Bldg. Number:</label>
					<asp:TextBox ID="uiBldgNum" CssClass="form-control" runat="server" Text='<%# Bind("Bldg") %>' />
				</div>
				
				<div class="form-group col-sm-2">
					<label for="uiRoomNum">Room Number:</label>
					<asp:TextBox ID="uiRoomNum" CssClass="form-control" runat="server" Text='<%# Bind("Room") %>' />
				</div>
				
				<div class="form-group col-sm-2">
					<label for="uiOffice">Office:</label>
					<asp:TextBox ID="uiOffice" CssClass="form-control" runat="server" Text='<%# Bind("Office") %>' />
				</div>

				<div class="form-group col-sm-3">
					<label for="uiEmail">AKO Email:</label>
					<asp:TextBox ID="uiEmail" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' />
				</div>

				<div class="form-group col-sm-3">
					<label for="uiPhone">Phone Number:</label>
					<asp:TextBox ID="uiPhone" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' />
				</div>
			</section>

			<section class="row">
				<div class="form-group col-sm-3">
					<label for="uiDepartment">Department:</label>
					<asp:DropDownList ID="uiDepartment" CssClass="form-control" runat="server" Text='<%# Bind("Department") %>'>
						<asp:ListItem>default</asp:ListItem>
					</asp:DropDownList>
				</div>
					
				<div class="form-group col-sm-3">
					<label for="uiOrg">Organization:</label>
					<asp:DropDownList ID="uiOrg" CssClass="form-control" runat="server" Text='<%# Bind("Org") %>'>
						<asp:ListItem>default</asp:ListItem>
					</asp:DropDownList>
				</div>

				<div class="form-group col-sm-3">
					<label for="uiBranch">Branch:</label>
					<asp:DropDownList ID="uiBranch" CssClass="form-control" runat="server" Text='<%# Bind("Branch") %>'>
						<asp:ListItem>default</asp:ListItem>
					</asp:DropDownList>
				</div>
					
				<div class="form-group col-sm-3">
					<label for="uiInstallation">Installation:</label>
					<asp:DropDownList ID="uiInstallation" CssClass="form-control" runat="server" Text='<%# Bind("Installation") %>'>
						<asp:ListItem>default</asp:ListItem>
					</asp:DropDownList>
				</div>
			</section>
			<%--
			<div class="row">
				<div class="form-group col-sm-2">
					<label for="uiDateCreated">Date:</label>
						<asp:TextBox ID="uiDateCreated" CssClass="form-control" runat="server" Text='<%# Bind("Created") %>' ReadOnly="false" />
				</div>
			</div>
				--%>
			<div>
				<asp:Button ID="uiSubmitBtn" runat="server" Text="Submit" CommandName="Insert" CssClass="btn btn-default" />
				<asp:Button ID="uiCancelBtn" runat="server" CommandName="Cancel" Text="Reset form" CausesValidation="False" CssClass="btn btn-default" />
			</div>
		</InsertItemTemplate>
	</asp:FormView>
								
	<asp:EntityDataSource ID="uiAccountRequestEDS" runat="server" ConnectionString="name=CarsonAccountEntities" DefaultContainerName="CarsonAccountEntities" EnableFlattening="False" EnableInsert="True" EnableUpdate="True" EntitySetName="AccountRequests"></asp:EntityDataSource>

</asp:Content>

<asp:Content ID="childBtmScripts" ContentPlaceHolderID="masterBtmScripts" runat="server">
</asp:Content>
