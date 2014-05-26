<%@ Page Title="Request Type" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="RequestType.aspx.cs" Inherits="AccountCreation.RequestType" ClientIDMode="Static" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">

	<h2 class="page-header">Request Form</h2>
	<asp:Panel ID="_adCheckContainer" runat="server">
		<p class="lead">What type of account are you requesting?</p>
<%--		<div class="form-group">
			<div class="col-sm-2">
				<div class="radio">
					<asp:RadioButton ID="_niprAcct" Text="&nbsp;NIPR" runat="server" GroupName="RequestType" />
				</div>
			</div>
		</div>

		<div class="form-group">
			<div class="col-sm-2">
				<div class="radio">
					<asp:RadioButton ID="_siprAcct" runat="server" Text="&nbsp;SIPR" GroupName="RequestType" />
				</div>
			</div>
		</div>
			
		<div class="form-group">
			<div class="col-sm-2">
				<div class="radio">
					<asp:RadioButton ID="_epAcct" runat="server" Text="&nbsp;EP" GroupName="RequestType" />
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-2">
				<div class="radio">
					<asp:RadioButton ID="_saAcct" runat="server" Text="&nbsp;SA" GroupName="RequestType" />
				</div>
			</div>
		</div>

		<div class="form-group">
			<div class="col-sm-2">
				<div class="radio">
					<asp:RadioButton ID="_vpnAcct" runat="server" Text="&nbsp;VPN" GroupName="RequestType"  />
				</div>
			</div>
		</div>--%>
		<div class="form-group">
			<div class="col-sm-2 col-md-1">
				<asp:RadioButtonList CssClass="radio" ID="_requestType" runat="server" RepeatLayout="Flow">
					<asp:ListItem>NIPR</asp:ListItem>
					<asp:ListItem>SIPR</asp:ListItem>
					<asp:ListItem>EP</asp:ListItem>
					<asp:ListItem>VPN</asp:ListItem>
				</asp:RadioButtonList>
			</div>
			<div class="col-sm-4">
				<asp:RequiredFieldValidator ID="_requestRequiredValidator" ControlToValidate="_requestType" runat="server" ErrorMessage="You must select an option." CssClass="label label-warning" Display="Dynamic"></asp:RequiredFieldValidator>
			</div>
		</div>
		<asp:Button role="button" ID="_submitBtn" runat="server" Text="Submit" CssClass="btn btn-primary" PostBackUrl="~/RequestAccount.aspx"  />
		
			
	</asp:Panel>
</asp:Content>

<asp:Content ID="_childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
