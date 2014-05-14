<%@ Page Title="Request Form" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="RequestType.aspx.cs" Inherits="AccountCreation.RequestType" ClientIDMode="Static" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">

	<h2 class="page-header">Request Form</h2>
	<asp:Panel ID="_adCheckContainer" runat="server">
		<p class="lead">What type of account are you requesting?</p>
		<div class="form-group">
			<div class="col-sm-1">
				<div class="checkbox">
					<asp:CheckBox ID="_niprAcct" runat="server" Text="&nbsp;NIPR" />
				</div>
			</div>
		</div>

		<div class="form-group">
			<div class="col-sm-1">
				<div class="checkbox">
					<asp:CheckBox ID="_siprAcct" runat="server" Text="&nbsp;SIPR" />
				</div>
			</div>
		</div>
			
		<div class="form-group">
			<div class="col-sm-1">
				<div class="checkbox">
					<asp:CheckBox ID="_epAcct" runat="server" Text="&nbsp;EP" />
				</div>
			</div>
		</div>
			
		<div class="form-group">
			<div class="col-sm-1">
				<div class="checkbox">
					<asp:CheckBox ID="_vpnAcct" runat="server" Text="&nbsp;VPN" />
				</div>
			</div>
		</div>

		<asp:Button role="button" ID="_submitBtn" data-loading-text="Please wait while we verfiy any existing accounts..." runat="server" Text="Submit" CssClass="btn btn-primary" PostBackUrl="~/RequestAccount.aspx" />		
	</asp:Panel>

</asp:Content>

<asp:Content ID="_childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
