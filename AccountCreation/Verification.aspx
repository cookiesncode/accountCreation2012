<%@ Page Title="Request Verification" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Verification.aspx.cs" Inherits="AccountCreation.Verification" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2 class="page-header">Request Verification</h2>
	<p>Please verify this information is correct.</p>
	
	<asp:FormView ID="_verifyForm" runat="server" RenderOuterTable="False" DataKeyNames="Edipi" DataSourceID="_verifyEDS" OnDataBound="_rank_DataBound">
		<EditItemTemplate>
			Edipi:
			<asp:Label ID="EdipiLabel1" runat="server" Text='<%# Eval("Edipi") %>' />
			<br />
			Email:
			<asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' />
			<br />
			LName:
			<asp:TextBox ID="LNameTextBox" runat="server" Text='<%# Bind("LName") %>' />
			<br />
			FName:
			<asp:TextBox ID="FNameTextBox" runat="server" Text='<%# Bind("FName") %>' />
			<br />
			Mi:
			<asp:TextBox ID="MiTextBox" runat="server" Text='<%# Bind("Mi") %>' />
			<br />
			Rank:
			
			<asp:DropDownList ID="_Rank" runat="server" SelectedValue='<%# Bind("Rank") %>' DataSourceID="_verifyEDS" DataTextField="Rank" DataValueField="Rank"></asp:DropDownList>
			<br />
			Org:
			<asp:TextBox ID="OrgTextBox" runat="server" Text='<%# Bind("Org") %>' />
			<br />
			Department:
			<asp:TextBox ID="DepartmentTextBox" runat="server" Text='<%# Bind("Department") %>' />
			<br />
			Installation:
			<asp:TextBox ID="InstallationTextBox" runat="server" Text='<%# Bind("Installation") %>' />
			<br />
			Branch:
			<asp:TextBox ID="BranchTextBox" runat="server" Text='<%# Bind("Branch") %>' />
			<br />
			Bldg:
			<asp:TextBox ID="BldgTextBox" runat="server" Text='<%# Bind("Bldg") %>' />
			<br />
			Room:
			<asp:TextBox ID="RoomTextBox" runat="server" Text='<%# Bind("Room") %>' />
			<br />
			Office:
			<asp:TextBox ID="OfficeTextBox" runat="server" Text='<%# Bind("Office") %>' />
			<br />
			Phone:
			<asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' />
			<br />
			Persona:
			<asp:TextBox ID="PersonaTextBox" runat="server" Text='<%# Bind("Persona") %>' />
			<br />
			Created:
			<asp:TextBox ID="CreatedTextBox" runat="server" Text='<%# Bind("Created") %>' />
			<br />
			ModifiedDate:
			<asp:TextBox ID="ModifiedDateTextBox" runat="server" Text='<%# Bind("ModifiedDate") %>' />
			<br />
			SamAccountName:
			<asp:TextBox ID="SamAccountNameTextBox" runat="server" Text='<%# Bind("SamAccountName") %>' />
			<br />
			HomeFolder:
			<asp:TextBox ID="HomeFolderTextBox" runat="server" Text='<%# Bind("HomeFolder") %>' />
			<br />
			NiprReg:
			<asp:TextBox ID="NiprRegTextBox" runat="server" Text='<%# Bind("NiprReg") %>' />
			<br />
			NiprSa:
			<asp:TextBox ID="NiprSaTextBox" runat="server" Text='<%# Bind("NiprSa") %>' />
			<br />
			NiprEp:
			<asp:TextBox ID="NiprEpTextBox" runat="server" Text='<%# Bind("NiprEp") %>' />
			<br />
			Vpn:
			<asp:TextBox ID="VpnTextBox" runat="server" Text='<%# Bind("Vpn") %>' />
			<br />
			Sipr:
			<asp:TextBox ID="SiprTextBox" runat="server" Text='<%# Bind("Sipr") %>' />
			<br />
			SupSigned:
			<asp:TextBox ID="SupSignedTextBox" runat="server" Text='<%# Bind("SupSigned") %>' />
			<br />
			SecSigned:
			<asp:TextBox ID="SecSignedTextBox" runat="server" Text='<%# Bind("SecSigned") %>' />
			<br />
			AcctStatus:
			<asp:TextBox ID="AcctStatusTextBox" runat="server" Text='<%# Bind("AcctStatus") %>' />
			<br />
			SupName:
			<asp:TextBox ID="SupNameTextBox" runat="server" Text='<%# Bind("SupName") %>' />
			<br />
			SecName:
			<asp:TextBox ID="SecNameTextBox" runat="server" Text='<%# Bind("SecName") %>' />
			<br />
			<asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
			&nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
		</EditItemTemplate>
		<InsertItemTemplate>
			Edipi:
			<asp:TextBox ID="EdipiTextBox" runat="server" Text='<%# Bind("Edipi") %>' />
			<br />
			Email:
			<asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' />
			<br />
			LName:
			<asp:TextBox ID="LNameTextBox" runat="server" Text='<%# Bind("LName") %>' />
			<br />
			FName:
			<asp:TextBox ID="FNameTextBox" runat="server" Text='<%# Bind("FName") %>' />
			<br />
			Mi:
			<asp:TextBox ID="MiTextBox" runat="server" Text='<%# Bind("Mi") %>' />
			<br />
			Rank:
			<asp:TextBox ID="RankTextBox" runat="server" Text='<%# Bind("Rank") %>' />
			<br />
			Org:
			<asp:TextBox ID="OrgTextBox" runat="server" Text='<%# Bind("Org") %>' />
			<br />
			Department:
			<asp:TextBox ID="DepartmentTextBox" runat="server" Text='<%# Bind("Department") %>' />
			<br />
			Installation:
			<asp:TextBox ID="InstallationTextBox" runat="server" Text='<%# Bind("Installation") %>' />
			<br />
			Branch:
			<asp:TextBox ID="BranchTextBox" runat="server" Text='<%# Bind("Branch") %>' />
			<br />
			Bldg:
			<asp:TextBox ID="BldgTextBox" runat="server" Text='<%# Bind("Bldg") %>' />
			<br />
			Room:
			<asp:TextBox ID="RoomTextBox" runat="server" Text='<%# Bind("Room") %>' />
			<br />
			Office:
			<asp:TextBox ID="OfficeTextBox" runat="server" Text='<%# Bind("Office") %>' />
			<br />
			Phone:
			<asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' />
			<br />
			Persona:
			<asp:TextBox ID="PersonaTextBox" runat="server" Text='<%# Bind("Persona") %>' />
			<br />
			Created:
			<asp:TextBox ID="CreatedTextBox" runat="server" Text='<%# Bind("Created") %>' />
			<br />
			ModifiedDate:
			<asp:TextBox ID="ModifiedDateTextBox" runat="server" Text='<%# Bind("ModifiedDate") %>' />
			<br />
			SamAccountName:
			<asp:TextBox ID="SamAccountNameTextBox" runat="server" Text='<%# Bind("SamAccountName") %>' />
			<br />
			HomeFolder:
			<asp:TextBox ID="HomeFolderTextBox" runat="server" Text='<%# Bind("HomeFolder") %>' />
			<br />
			NiprReg:
			<asp:TextBox ID="NiprRegTextBox" runat="server" Text='<%# Bind("NiprReg") %>' />
			<br />
			NiprSa:
			<asp:TextBox ID="NiprSaTextBox" runat="server" Text='<%# Bind("NiprSa") %>' />
			<br />
			NiprEp:
			<asp:TextBox ID="NiprEpTextBox" runat="server" Text='<%# Bind("NiprEp") %>' />
			<br />
			Vpn:
			<asp:TextBox ID="VpnTextBox" runat="server" Text='<%# Bind("Vpn") %>' />
			<br />
			Sipr:
			<asp:TextBox ID="SiprTextBox" runat="server" Text='<%# Bind("Sipr") %>' />
			<br />
			SupSigned:
			<asp:TextBox ID="SupSignedTextBox" runat="server" Text='<%# Bind("SupSigned") %>' />
			<br />
			SecSigned:
			<asp:TextBox ID="SecSignedTextBox" runat="server" Text='<%# Bind("SecSigned") %>' />
			<br />
			AcctStatus:
			<asp:TextBox ID="AcctStatusTextBox" runat="server" Text='<%# Bind("AcctStatus") %>' />
			<br />
			SupName:
			<asp:TextBox ID="SupNameTextBox" runat="server" Text='<%# Bind("SupName") %>' />
			<br />
			SecName:
			<asp:TextBox ID="SecNameTextBox" runat="server" Text='<%# Bind("SecName") %>' />
			<br />
			<asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
			&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
		</InsertItemTemplate>
		<ItemTemplate>
			Edipi:
			<asp:Label ID="EdipiLabel" runat="server" Text='<%# Eval("Edipi") %>' />
			<br />
			Email:
			<asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
			<br />
			LName:
			<asp:Label ID="LNameLabel" runat="server" Text='<%# Bind("LName") %>' />
			<br />
			FName:
			<asp:Label ID="FNameLabel" runat="server" Text='<%# Bind("FName") %>' />
			<br />
			Mi:
			<asp:Label ID="MiLabel" runat="server" Text='<%# Bind("Mi") %>' />
			<br />
			Rank:
			<asp:Label ID="RankLabel" runat="server" Text='<%# Bind("Rank") %>' />
			<br />
			Org:
			<asp:Label ID="OrgLabel" runat="server" Text='<%# Bind("Org") %>' />
			<br />
			Department:
			<asp:Label ID="DepartmentLabel" runat="server" Text='<%# Bind("Department") %>' />
			<br />
			Installation:
			<asp:Label ID="InstallationLabel" runat="server" Text='<%# Bind("Installation") %>' />
			<br />
			Branch:
			<asp:Label ID="BranchLabel" runat="server" Text='<%# Bind("Branch") %>' />
			<br />
			Bldg:
			<asp:Label ID="BldgLabel" runat="server" Text='<%# Bind("Bldg") %>' />
			<br />
			Room:
			<asp:Label ID="RoomLabel" runat="server" Text='<%# Bind("Room") %>' />
			<br />
			Office:
			<asp:Label ID="OfficeLabel" runat="server" Text='<%# Bind("Office") %>' />
			<br />
			Phone:
			<asp:Label ID="PhoneLabel" runat="server" Text='<%# Bind("Phone") %>' />
			<br />
			Persona:
			<asp:Label ID="PersonaLabel" runat="server" Text='<%# Bind("Persona") %>' />
			<br />
			Created:
			<asp:Label ID="CreatedLabel" runat="server" Text='<%# Bind("Created") %>' />
			<br />
			ModifiedDate:
			<asp:Label ID="ModifiedDateLabel" runat="server" Text='<%# Bind("ModifiedDate") %>' />
			<br />
			SamAccountName:
			<asp:Label ID="SamAccountNameLabel" runat="server" Text='<%# Bind("SamAccountName") %>' />
			<br />
			HomeFolder:
			<asp:Label ID="HomeFolderLabel" runat="server" Text='<%# Bind("HomeFolder") %>' />
			<br />
			NiprReg:
			<asp:Label ID="NiprRegLabel" runat="server" Text='<%# Bind("NiprReg") %>' />
			<br />
			NiprSa:
			<asp:Label ID="NiprSaLabel" runat="server" Text='<%# Bind("NiprSa") %>' />
			<br />
			NiprEp:
			<asp:Label ID="NiprEpLabel" runat="server" Text='<%# Bind("NiprEp") %>' />
			<br />
			Vpn:
			<asp:Label ID="VpnLabel" runat="server" Text='<%# Bind("Vpn") %>' />
			<br />
			Sipr:
			<asp:Label ID="SiprLabel" runat="server" Text='<%# Bind("Sipr") %>' />
			<br />
			SupSigned:
			<asp:Label ID="SupSignedLabel" runat="server" Text='<%# Bind("SupSigned") %>' />
			<br />
			SecSigned:
			<asp:Label ID="SecSignedLabel" runat="server" Text='<%# Bind("SecSigned") %>' />
			<br />
			AcctStatus:
			<asp:Label ID="AcctStatusLabel" runat="server" Text='<%# Bind("AcctStatus") %>' />
			<br />
			SupName:
			<asp:Label ID="SupNameLabel" runat="server" Text='<%# Bind("SupName") %>' />
			<br />
			SecName:
			<asp:Label ID="SecNameLabel" runat="server" Text='<%# Bind("SecName") %>' />
			<br />
			<asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
			&nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
			&nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
		</ItemTemplate>
	</asp:FormView>

	<asp:EntityDataSource ID="_verifyEDS" runat="server" ConnectionString="name=CarsonAccountEntities" DefaultContainerName="CarsonAccountEntities" EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True" EntitySetName="AccountRequests"></asp:EntityDataSource>
</asp:Content>

<asp:Content ID="_childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
</asp:Content>
