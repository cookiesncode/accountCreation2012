<%@ Page Title="Request Form Submitted" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Success.aspx.cs" Inherits="AccountCreation.Success" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2 class="page-header">Request Submitted</h2>
	<h3>Please follow these next steps to complete the process.</h3>
	<ol>
		<li>Use the form below to notify your approval staff, e.g., your supervisor and security manager, that your request needs to be verified. If you requested a VPN account then only your supervisor needs to verify your request.</li>
		<li>Wait until your supervisor notifies you that your account has been created. Until then, do not login into the Fort Carson network.</li>
	</ol>
    <div class="well">
    <asp:MultiView ID="_multiviewForm" ActiveViewIndex="0" runat="server">
        <asp:View ID="_viewEmailForm" runat="server"> 
            <h4>Email Form:</h4>
            <p>Enter the email addresses for whom you want to send your account request:</p>
	        <div class="form-group">
		        <div class="col-sm-6">
			        <asp:TextBox ID="_email" CssClass="form-control" runat="server" />
			        <asp:RequiredFieldValidator CssClass="label label-warning" ID="_emailRequiredValidator" runat="server" ErrorMessage="Email: Please enter a valid email address." ControlToValidate="_email" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
			        <asp:RegularExpressionValidator ID="_emailExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="Email: Please enter a valid email address." Display="Dynamic" ControlToValidate="_email" Text="Requires your attention." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
		        </div>
	        </div>
	        <asp:Button ID="_button" data-loading-text="Sending email..." CssClass="btn btn-primary" runat="server" CausesValidation="True" Text="Send Email" OnClick="_button_Click" />
        </asp:View>
        <asp:View ID="_viewEmailSent" runat="server">
            <p>Your email has been sent.</p>
        </asp:View>
    </asp:MultiView>
    </div>
</asp:Content>

<asp:Content ID="_masterBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
