﻿<%@ Page Title="Request Form" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="RequestType.aspx.cs" Inherits="AccountCreation.RequestType" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2>Request Form</h2>
	<asp:Panel ID="_adCheckContainer" runat="server">
		<p class="lead">What type of account are you requesting?</p>
		<section class="row">		
			<div class="form-group col-sm-1">
				<asp:CheckBox ID="_niprAcct" runat="server" Text="&nbsp;NIPR" />
			</div>

			<div class="form-group col-sm-1">
				<asp:CheckBox ID="_siprAcct" runat="server" Text="&nbsp;SIPR" />
			</div>
			
			<div class="form-group col-sm-1">
				<asp:CheckBox ID="_epAcct" runat="server" Text="&nbsp;EP" />
			</div>
			
			<div class="form-group col-sm-1">
				<asp:CheckBox ID="_vpnAcct" runat="server" Text="&nbsp;VPN" />
			</div>
		</section>
		<asp:Button ID="_submitBtn" runat="server" Text="Submit" CssClass="btn btn-default" PostBackUrl="~/RequestAccount.aspx" />		
	</asp:Panel>

</asp:Content>

<asp:Content ID="_childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
