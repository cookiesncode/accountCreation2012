<%@ Page Title="Request Type" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="RequestType.aspx.cs" Inherits="AccountCreation.RequestType" ClientIDMode="Static" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">

	<h2 class="page-header">Request Form</h2>
	<asp:Panel ID="_adCheckContainer" runat="server">
		<div class="row">
			<div class="col-sm-6">
				<div id="requestTypePanel" class="panel panel-default">
					<div class="panel-heading">
						<p class="lead">Please choose the account type.</p>
					</div>
					<div class="panel-body">
                        <p>Do you want to create or delete an existing account?</p>
                        <div class="form-group">
                            <div class="col-sm-6">
                                <asp:RadioButtonList ID="_requestType" CssClass="radio requestRadio" RepeatLayout="Flow" runat="server">
                                    <asp:ListItem Value="Create">Create account</asp:ListItem>
                                    <asp:ListItem Value="Delete">Delete account</asp:ListItem>
                                </asp:RadioButtonList>
								<asp:RequiredFieldValidator ID="_createDeleteRequiredValidator" ControlToValidate="_requestType" runat="server" ErrorMessage="You must select an option." CssClass="label label-warning" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <p>What type of account is it?</p>
						<div class="form-group">
							<div class="col-sm-12">
								<asp:RadioButtonList CssClass="radio requestRadios" ID="_accountType" runat="server" RepeatLayout="Flow">
                                    <asp:ListItem Value="NIPR">NIPR - Fort Carson User Account</asp:ListItem>
                                    <asp:ListItem Value="SIPR">SIPR - Classified Network</asp:ListItem>
                                    <asp:ListItem Value="EP">EP/SA - Elevated Privileges</asp:ListItem>
                                    <asp:ListItem Value="VPN">VPN - Virtual Private Network</asp:ListItem>
								</asp:RadioButtonList>
								<asp:RequiredFieldValidator ID="_requestRequiredValidator" ControlToValidate="_accountType" runat="server" ErrorMessage="You must select an option." CssClass="label label-warning" Display="Dynamic"></asp:RequiredFieldValidator>
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<asp:Button data-loading-text="Please wait, while we verify any existing accounts..." role="button" ID="_submitBtn" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="_submitBtn_Click" />
					</div>
				</div>
			</div>
		</div>
	</asp:Panel>

</asp:Content>

<asp:Content ID="_childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
