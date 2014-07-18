<%@ Page Title="Fort Carson NEC | User Account Center" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AccountCreation.Default" %>

<asp:Content ID="childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2 class="page-header">What would you like to do?</h2>
	<div class="start-links">
		<a class="btn btn-primary" href="request-type.aspx">Account creation or deletion</a>
		<a class="btn btn-primary" href="verification.aspx">Review an existing request</a>
	</div>
</asp:Content>

<asp:Content ID="childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server"></asp:Content>
