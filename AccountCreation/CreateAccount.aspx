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
		<asp:FormView ID="uiAccountRequestForm" runat="server" DataKeyNames="Edipi" 
		DataSourceID="uiAccountRequestEDS" DefaultMode="Insert" RenderOuterTable="False">
			
			<InsertItemTemplate>
				<section class="row">
					<div class="form-group col-sm-2">
						<label for="uiEdipi">EDIPI:</label>
						<asp:TextBox ID="uiEdipi" CssClass="form-control" runat="server" Text='<%# Bind("Edipi") %>'  />
					</div>

					<div class="form-group col-sm-3">
						<label for="uiLname">Last Name:</label>
						<asp:TextBox ID="uiLname" CssClass="form-control" runat="server" Text='<%# Bind("LName") %>' />
					</div>

					<div class="form-group col-sm-3">
						<label for="uiFname">First Name:</label>
						<asp:TextBox ID="uiFname" CssClass="form-control" runat="server" Text='<%# Bind("FName") %>' />
					</div>
				
					<div class="form-group col-sm-1">
						<label for="uiMiddleInitial">MI:</label>
						<asp:TextBox ID="uiMiddleInitial" CssClass="form-control" runat="server" Text='<%# Bind("Mi") %>' />
					</div>

					<div class="form-group col-sm-3">
						<label for="uiRank">Rank:</label>
						<asp:DropDownList ID="uiRank" CssClass="form-control" runat="server" Text='<%# Bind("Rank") %>'>
							<asp:ListItem>SGT</asp:ListItem>
						</asp:DropDownList>
					</div>
				</section>

				<section class="row">			
					<div class="form-group col-sm-2">
						<label for="uiBldgNum">Bldg. Number:</label>
						<asp:TextBox ID="uiBldgNum" CssClass="form-control" runat="server" Text='<%# Bind("Bldg") %>' />
					</div>
				
					<div class="form-group col-sm-2">
						<label for="uiRoomNum">Room Number:</label>
						<asp:TextBox ID="uiRoomNum" CssClass="form-control" runat="server" Text='<%# Bind("Room") %>' />
					</div>
				
					<div class="form-group col-sm-2">
						<label for="uiOffice">Office:</label>
						<asp:TextBox ID="uiOffice" CssClass="form-control" runat="server" Text='<%# Bind("Office") %>' />
					</div>

					<div class="form-group col-sm-3">
						<label for="uiEmail">AKO Email:</label>
						<asp:TextBox ID="uiEmail" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' />
					</div>

					<div class="form-group col-sm-3">
						<label for="uiPhone">Phone Number:</label>
						<asp:TextBox ID="uiPhone" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' />
					</div>
				</section>

				<section class="row">
					<div class="form-group col-sm-3">
						<label for="uiDepartment">Department:</label>
						<asp:DropDownList ID="uiDepartment" CssClass="form-control" runat="server" Text='<%# Bind("Department") %>'>
							<asp:ListItem>default</asp:ListItem>
						</asp:DropDownList>
					</div>
					
					<div class="form-group col-sm-3">
						<label for="uiOrg">Organization:</label>
						<asp:DropDownList ID="uiOrg" CssClass="form-control" runat="server" Text='<%# Bind("Org") %>'>
							<asp:ListItem>default</asp:ListItem>
						</asp:DropDownList>
					</div>

					<div class="form-group col-sm-3">
						<label for="uiBranch">Branch:</label>
						<asp:DropDownList ID="uiBranch" CssClass="form-control" runat="server" Text='<%# Bind("Branch") %>'>
							<asp:ListItem>default</asp:ListItem>
						</asp:DropDownList>
					</div>
					
					<div class="form-group col-sm-3">
						<label for="uiInstallation">Installation:</label>
						<asp:DropDownList ID="uiInstallation" CssClass="form-control" runat="server" Text='<%# Bind("Installation") %>'>
							<asp:ListItem>default</asp:ListItem>
						</asp:DropDownList>
					</div>
				</section>
				<div class="row clearfix">
					<div class="form-group col-sm-2">
						<label for="uiDateCreated">Date:</label>
							<asp:TextBox ID="uiDateCreated" CssClass="form-control" runat="server" Text='<%# Bind("Created") %>' ReadOnly="false" />
					</div>
				</div>
				<div>
					<asp:Button ID="submitBtn" runat="server" Text="Submit" CommandName="Insert" CssClass="btn btn-default" />
					<asp:Button ID="cancelBtn" runat="server" CommandName="Cancel" Text="Reset form" CausesValidation="False" CssClass="btn btn-default" />
				</div>
			</InsertItemTemplate>

		</asp:FormView>
								
	</article>
	<asp:EntityDataSource ID="uiAccountRequestEDS" runat="server" ConnectionString="name=CarsonAccountEntities" DefaultContainerName="CarsonAccountEntities" EnableFlattening="False" EnableInsert="True" EnableUpdate="True" EntitySetName="AccountRequests"></asp:EntityDataSource>
	</form>				

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="_assets/js/bootstrap.min.js"></script>
</body>
</html>