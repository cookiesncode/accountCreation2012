<%@ Page Title="" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AccountCreation.Default" %>

<asp:Content ID="childTitle" ContentPlaceHolderID="masterTitle" runat="server">
	Fort Carson NEC | Account Creation
</asp:Content>

<asp:Content ID="childHead" ContentPlaceHolderID="masterHead" runat="server">
</asp:Content>

<asp:Content ID="childMainContent" ContentPlaceHolderID="masterMainContent" runat="server">
	<section class="row">
		<h2>Please select an option below</h2>
		<asp:HyperLink ID="uiRequestLink" runat="server" NavigateUrl="~/RequestAccount.aspx">Request a new account</asp:HyperLink>
	</section>
</asp:Content>

<asp:Content ID="childBtmScripts" ContentPlaceHolderID="masterBtmScripts" runat="server"></asp:Content>
