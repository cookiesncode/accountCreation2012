<%@ Page Title="Fort Carson NEC | User Account Center" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AccountCreation.Default" %>

<asp:Content ID="childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2 class="page-header">What would you like to do?</h2>
	<div class="start-links">
		<a class="btn btn-primary" href="RequestType.aspx">Request a new account</a>
		<a class="btn btn-primary" href="Verification.aspx">Verify and sign an existing request</a>
	</div>
</asp:Content>

<asp:Content ID="childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server"></asp:Content>
