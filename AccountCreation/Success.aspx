<%@ Page Title="Request Form Submitted" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Success.aspx.cs" Inherits="AccountCreation.Success" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2 class="page-header">Your request has been submitted</h2>
	<h3>Please follow these next steps to complete the process.</h3>
	<ol>
		<li>Use the form below to notify your approval staff that your request needs to be verified. If you requested a VPN account then only your supervisor needs to verify your request.</li>
		<li>Wait until your supervisor notifies you that your account has been created. Until then, do not login into the Fort Carson network.</li>
	</ol>
    <div class="email-form-container">
        <asp:MultiView ID="_multiviewForm" ActiveViewIndex="0" runat="server">
            <asp:View ID="_viewEmailForm" runat="server">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4>Email Form</h4>
                    </div>
                    <div class="panel-body"> 
                        <p>Enter the email addresses of your approval staff.</p>
	                    <div class="form-group">
		                    <div class="col-sm-12">
                                <label for="_supervisorEmail">Supervisor's email:</label>
			                    <asp:TextBox ID="_supervisorEmail" CssClass="form-control" runat="server" />
			                    <asp:RequiredFieldValidator CssClass="label label-warning" ID="_supEmailRequiredValidator" runat="server" ErrorMessage="Please enter a valid email address." ControlToValidate="_supervisorEmail" Display="Dynamic"></asp:RequiredFieldValidator>
			                    <asp:RegularExpressionValidator ID="_supEmailExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="Please enter a valid email address." Display="Dynamic" ControlToValidate="_supervisorEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
		                    </div>
	                    </div>
                        <asp:PlaceHolder ID="_securityPlaceHolder" runat="server">
	                        <div class="form-group">
		                        <div class="col-sm-12">
                                    <label for="_securityEmail">Security Manager's email:</label>
			                        <asp:TextBox ID="_securityEmail" CssClass="form-control" runat="server" />
                                    <asp:RequiredFieldValidator CssClass="label label-warning" ID="_secEmailRequiredValidator" runat="server" ErrorMessage="Please enter a valid email address." ControlToValidate="_securityEmail" Display="Dynamic"></asp:RequiredFieldValidator>
			                        <asp:RegularExpressionValidator ID="_secEmailExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="Please enter a valid email address." Display="Dynamic" ControlToValidate="_securityEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
		                        </div>
	                        </div>
                        </asp:PlaceHolder>
                        <div class="form-group">
		                    <div class="col-sm-12">
                                <label for="_link">Verification Link:</label>
			                    <p class="form-control-static"><asp:Label ID="_verificationLink" runat="server"></asp:Label></p>
		                    </div>
	                    </div>
                        <div class="form-group">
		                    <div class="col-sm-12">
                                <label for="_emailSignature">Sent from:</label>
			                    <p class="form-control-static"><asp:Label ID="_emailSignature" runat="server"></asp:Label></p>
		                    </div>
	                    </div>
                    </div>
                    <div class="panel-footer">
                        <asp:Button ID="_button" data-loading-text="Sending email..." CssClass="btn btn-primary" runat="server" CausesValidation="True" Text="Send Email" OnClick="_button_Click" />
                    </div>
                </div>
            </asp:View>
            <asp:View ID="_viewEmailSent" runat="server">
                <p class="email-form-sent bg-primary">Your email has been sent.</p>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>

<asp:Content ID="_masterBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
