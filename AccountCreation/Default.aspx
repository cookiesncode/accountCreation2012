<%@ Page Title="Fort Carson NEC | User Account Center" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AccountCreation.Default" %>

<asp:Content ID="childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<section class="row">
		<h2>Please select an option below</h2>
		<asp:HyperLink ID="uiRequestLink" runat="server" NavigateUrl="~/RequestAccount.aspx">Request a new account</asp:HyperLink>
	</section>
</asp:Content>

<asp:Content ID="childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server"></asp:Content>
