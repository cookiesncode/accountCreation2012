<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateAccount.aspx.cs" Inherits="AccountCreation.CreateAccount" %>

<!DOCTYPE html>

<html lang="en">
<head id="Head1" runat="server">
	<title>Fort Carson | Account Creation Request Form</title>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="_assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="_assets/css/bootstrap-theme.min.css">
	<link href="_assets/css/app.css" rel="stylesheet" />
	<!--[if lt IE 9]>
		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.3.0/respond.js"></script>
<![endif]-->
</head>

<body>
	<form id="form1" role="form" runat="server">
	<article class="container">
		<section class="row">
			<header class="col-lg-12">
				<h1>User Account Creation Form</h1>
			</header>
		</section>
		<asp:FormView ID="userEntryForm" runat="server" DataKeyNames="EDIPI" 
		DataSourceID="acctCreateAuto" DefaultMode="Insert" RenderOuterTable="False">
			<InsertItemTemplate>
				<section class="row">
					<div class="form-group col-sm-2">
						<label for="edipi_txtbox">EDIPI:</label>
						<asp:TextBox ID="edipi_txtbox" CssClass="form-control" runat="server" Text='<%# Bind("EDIPI") %>' />
					</div>

					<div class="form-group col-sm-3">
						<label for="lName_txtbox">Last Name:</label>
						<asp:TextBox ID="lName_txtbox" CssClass="form-control" runat="server" Text='<%# Bind("LName") %>' />
					</div>

					<div class="form-group col-sm-3">
						<label for="fName_txtbox">First Name:</label>
						<asp:TextBox ID="fName_txtbox" CssClass="form-control" runat="server" Text='<%# Bind("FName") %>' />
					</div>
				
					<div class="form-group col-sm-1">
						<label for="mInitial_txtbox">MI:</label>
						<asp:TextBox ID="mInitial_txtbox" CssClass="form-control" runat="server" Text='<%# Bind("MI") %>' />
					</div>

					<div class="form-group col-sm-3">
						<label for="rank_dropDown">Rank:</label>
						<asp:DropDownList ID="rank_dropDown" CssClass="form-control" runat="server" Text='<%# Bind("Rank") %>'>
							<asp:ListItem>SGT</asp:ListItem>
						</asp:DropDownList>
					</div>
				</section>

				<section class="row">			
					<div class="form-group col-sm-2">
						<label for="bldgNum_txtbox">Bldg. Number:</label>
						<asp:TextBox ID="bldgNum_txtbox" CssClass="form-control" runat="server" Text='<%# Bind("Bldg") %>' />
					</div>
				
					<div class="form-group col-sm-2">
						<label for="roomNum_txtbox">Room Number:</label>
						<asp:TextBox ID="roomNumber_txtbox" CssClass="form-control" runat="server" Text='<%# Bind("Room") %>' />
					</div>
				
					<div class="form-group col-sm-2">
						<label for="office_txtbox">Office:</label>
						<asp:TextBox ID="office_txtbox" CssClass="form-control" runat="server" Text='<%# Bind("Office") %>' />
					</div>

					<div class="form-group col-sm-3">
						<label for="_email_txtbox">AKO Email:</label>
						<asp:TextBox ID="_email_txtbox" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' />
					</div>

					<div class="form-group col-sm-3">
						<label for="phone_txtbox">Phone Number:</label>
						<asp:TextBox ID="phone_txtbox" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' />
					</div>
				</section>

				<section class="row">
					<div class="form-group col-sm-3">
						<label for="department_dropDown">Department:</label>
						<asp:DropDownList ID="department_dropDown" CssClass="form-control" runat="server" Text='<%# Bind("Department") %>'>
							<asp:ListItem>default</asp:ListItem>
						</asp:DropDownList>
					</div>
					
					<div class="form-group col-sm-3">
						<label for="org_dropDown">Organization:</label>
						<asp:DropDownList ID="org_dropDown" CssClass="form-control" runat="server" Text='<%# Bind("Org") %>'>
							<asp:ListItem>default</asp:ListItem>
						</asp:DropDownList>
					</div>

					<div class="form-group col-sm-3">
						<label for="branch_dropDown">Branch:</label>
						<asp:DropDownList ID="branch_dropDown" CssClass="form-control" runat="server" Text='<%# Bind("Branch") %>'>
							<asp:ListItem>default</asp:ListItem>
						</asp:DropDownList>
					</div>
					
					<div class="form-group col-sm-3">
						<label for="installation_dropDown">Installation:</label>
						<asp:DropDownList ID="installation_dropDown" CssClass="form-control" runat="server" Text='<%# Bind("Installation") %>'>
							<asp:ListItem>default</asp:ListItem>
						</asp:DropDownList>
					</div>
				</section>
				<asp:Button ID="submitBtn" runat="server" Text="Submit" CommandName="Insert" CssClass="btn btn-default" />				
				&nbsp;
				<asp:Button ID="cancelBtn" runat="server" CommandName="Cancel" Text="Reset form" CausesValidation="False" CssClass="btn btn-default" />
			</InsertItemTemplate>
		</asp:FormView>
								
	</article>

	</form>				

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="_assets/js/bootstrap.min.js"></script>
</body>
</html>