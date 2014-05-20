<%@ Page Title="Request Form Submitted" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Success.aspx.cs" Inherits="AccountCreation.Success" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2 class="page-header">Form Submitted</h2>
	<p class="lead">Please follow these next steps to complete the process.</p>
	<ol>
		<li>Send your supervisor and security manager the link below, so that they may review and verify your request.</li>
		<li>Wait until your supervisor notifies you that your account has been created. Until then, do not login into the Fort Carson network.</li>
	</ol>
	<p><asp:HyperLink ID="_verifyUrl" runat="server">HyperLink</asp:HyperLink></p>
</asp:Content>

<asp:Content ID="_masterBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
