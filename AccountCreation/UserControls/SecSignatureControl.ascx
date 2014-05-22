<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SecSignatureControl.ascx.cs" Inherits="AccountCreation.SecSignatureControl" %>

<div class="form-group">
	<label for="_securityCheckBox" class="col-sm-4 control-label">Security Manager:</label>
	<div class="col-sm-8">
		<div class="input-group">
			<span class="input-group-addon">
				<asp:CheckBox ID="_securityCheckBox"  runat="server" AutoPostBack="True" />
			</span>
			<asp:TextBox ID="_securitySignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("SecEdipi") %>' />
		</div>
		<asp:CompareValidator ID="_signatureCompareValidator" CssClass="label label-warning" ControlToValidate="_securitySignature" ControlToCompare="_supervisorSignature" runat="server" ErrorMessage="Signatures cannot be the same." Type="String" Operator="NotEqual" Text="Requires your attention" Display="Dynamic"></asp:CompareValidator>
		<asp:RequiredFieldValidator ID="_secSignRequiredValidator" runat="server" ErrorMessage="Signature Box: You must sign the form before applying your changes." Text="Requires your attention" Display="Dynamic" CssClass="label label-warning" ControlToValidate="_securitySignature"></asp:RequiredFieldValidator>
	</div>
</div>
