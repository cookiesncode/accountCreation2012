<%@ Page Title="Fort Carson NEC | User Account Center" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AccountCreation.Default" %>

<asp:Content ID="childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<section class="row">
		<h2 class="page-header">What would you like to do?</h2>
		<ul class="nav nav-pills">
			<li><a href="RequestType.aspx">Request a new account</a></li>
			<li><a href="RequestType.aspx">Verify and sign an existing request</a></li>
		</ul>
	</section>
</asp:Content>

<asp:Content ID="childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server"></asp:Content>
