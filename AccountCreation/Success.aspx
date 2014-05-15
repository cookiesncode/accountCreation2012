<%@ Page Title="Request Form Submitted" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Success.aspx.cs" Inherits="AccountCreation.Success" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2 class="page-header">Form Submitted</h2>
	<p>Please send the link below to your supervisor and security manager, so that they can verify your request and add their appropriate signatures.</p>
	<p><asp:HyperLink ID="_verifyUrl" runat="server">HyperLink</asp:HyperLink></p>
</asp:Content>

<asp:Content ID="_masterBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
