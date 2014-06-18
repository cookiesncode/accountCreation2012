<%@ Page Title="Request Form" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="RequestAccount.aspx.cs" Inherits="AccountCreation.RequestAccount" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2 class="page-header">Request Form</h2>	
	<asp:Panel ID="_niprResults" runat="server" Visible="false">
		<p>Our records indicate that you already have a NIPR account. The account display name is <strong><asp:Label ID="_niprName" runat="server" CssClass="text-warning"></asp:Label></strong>.</p>
	</asp:Panel>

	<asp:Panel ID="_vpnResults" runat="server" Visible="false">
		<p>Our records indicate that you already have a VPN account. The name of the VPN group you reside in is <strong><asp:Label ID="_vpnGroup" runat="server" CssClass="text-warning"></asp:Label></strong></p>
	</asp:Panel>

	<asp:Panel ID="_epResults" runat="server" Visible="false">
		<p>Our records indicate that you don't have a Fort Carson NIPR account. In order for you to create an account either than NIPR, you must have an existing NIPR account.</p>
	</asp:Panel>

	<asp:Panel ID="_redirectMessage" runat="server" Visible="false">
		<p>If you feel this is incorrect then please... or go to the <a href="RequestType.aspx" class="btn btn-primary btn-xs">Request Type</a> page and try again.</p>
	</asp:Panel>

	<asp:FormView ID="_formview" 
		runat="server" 
		DataKeyNames="Id"
		DataSourceID="_formviewEntitySource" 
		DefaultMode="Insert" 
		RenderOuterTable="False" 
		OnDataBound="_requestForm_DataBound" 
		OnItemInserted="_formview_ItemInserted" 
		OnItemInserting="_formview_ItemInserting"
		EnableViewState="True">
		<InsertItemTemplate>
			<div class="row">
				<div class="col-sm-7">
					<div class="panel panel-default">
						<div class="panel-heading">
							<p class="lead">Please fill out your information.</p>
							<p><strong class="text-info">Note:</strong> The EDIPI, last name, and first name fields are pre-populated from your CAC card. These are not editable.</p>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label for="_edipi" class="col-sm-4 col-md-4 control-label">EDIPI:</label>
								<div class="col-sm-7 col-md-6">
									<asp:TextBox ID="_edipi" CssClass="form-control" runat="server" Text='<%# Bind("Edipi") %>'  />
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_edipiRequiredValidator" runat="server" ErrorMessage="EDIPI: Please enter your EDIPI number." ControlToValidate="_edipi" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>

							<div class="form-group">
								<label for="_lName" class="col-sm-4 col-md-4 control-label">Last Name:</label>
								<div class="col-sm-7 col-md-6">
									<asp:TextBox ID="_lName" CssClass="form-control" runat="server" Text='<%# Bind("LName") %>' />
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_lNameRequiredValidator" runat="server" ErrorMessage="Last name: Please enter your last name." ControlToValidate="_lName" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>

							<div class="form-group">
								<label for="_fName" class="col-sm-4 col-md-4 control-label">First Name:</label>
								<div class="col-sm-7 col-md-6">
									<asp:TextBox ID="_fName" CssClass="form-control" runat="server" Text='<%# Bind("FName") %>' />
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_fNameRequiredValidator" runat="server" ErrorMessage="First name: Please enter your first name." ControlToValidate="_fName" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>
				
							<div class="form-group">
								<%-- TODO: FIX output from CAC --%>
								<label for="_middleInitial" class="col-sm-4 col-md-4 control-label">MI:</label>
								<div class="col-sm-3 col-md-2">
									<asp:TextBox ID="_middleInitial" CssClass="form-control" runat="server" Text='<%# Bind("Mi") %>' />
									<asp:CustomValidator ID="_middleInitialValidator" CssClass="label label-warning" ControlToValidate="_middleInitial" runat="server" ErrorMessage="MI: Please insert only one letter for your middle initial." Text="Requires your attention" OnServerValidate="_middleInitialValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
								</div>
							</div>

							<div class="form-group">
								<label for="_email" class="col-sm-4 col-md-4 control-label">Enterprise Email:</label>
								<div class="col-sm-7 col-md-6">
									<asp:TextBox ID="_email" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' />
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_emailRequiredValidator" runat="server" ErrorMessage="AKO Email: Please enter your AKO email address." ControlToValidate="_email" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="_emailExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="AKO Email: Please enter a valid email address." Display="Dynamic" ControlToValidate="_email" Text="Requires your attention." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
								</div>
							</div>

							<div class="form-group">
								<label for="_persona" class="col-sm-4 col-md-4 control-label">Persona Type:</label>
								<div class="col-sm-7 col-md-6">
									<asp:DropDownList ID="_persona" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Persona") %>' AppendDataBoundItems="True">
										<asp:ListItem Text="-- Select Persona --" Value="" />
									</asp:DropDownList>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_personaRequiredValidator" runat="server" ErrorMessage="Persona: Please select a Persona." ControlToValidate="_persona" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>
		
							<div class="form-group">
								<label for="_rank" class="col-sm-4 col-md-4 control-label">Rank:</label>
								<div class="col-sm-7 col-md-6">
									<asp:DropDownList ID="_rank" CssClass="form-control" runat="server" Text='<%# Bind("Rank") %>' AppendDataBoundItems="true">
										<asp:ListItem Text="-- Select Rank --" Value="" />
									</asp:DropDownList>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_rankRequiredValidator" runat="server" ErrorMessage="Rank: Please select your rank." ControlToValidate="_rank" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>
	
							<div class="form-group">
								<label for="_macom" class="col-sm-4 col-md-4 control-label">MACOM:</label>
								<div class="col-sm-7 col-md-6">
									<asp:DropDownList ID="_macom" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Macom") %>' AppendDataBoundItems="True">
										<asp:ListItem Text="-- Select a MACOM --" Value="" />
									</asp:DropDownList>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_macomRequiredValidator" runat="server" ErrorMessage="MACOM: Please select an option." ControlToValidate="_macom" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>

							<div class="form-group">
								<label for="_branch" class="col-sm-4 col-md-4 control-label">Branch:</label>
								<div class="col-sm-7 col-md-6">
									<asp:DropDownList ID="_branch" CssClass="form-control" runat="server" Text='<%# Bind("Branch") %>' AppendDataBoundItems="True">
										<asp:ListItem Text="-- Select Branch --" Value="" />
									</asp:DropDownList>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_branchRequiredValidator" runat="server" ErrorMessage="Branch: Please select your branch." ControlToValidate="_branch" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>

							<div class="form-group">
								<label for="_orgUnit" class="col-sm-4 col-md-4 control-label">Org/Unit:</label>
								<div class="col-sm-7 col-md-6">
									<asp:DropDownList ID="_orgUnit" CssClass="form-control" runat="server" Text='<%# Bind("OrgUnit") %>' AppendDataBoundItems="True">
										<asp:ListItem Text="-- Select Org/Unit --" Value="" />
									</asp:DropDownList>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_deptRequiredValidator" runat="server" ErrorMessage="Department: Please select your department." ControlToValidate="_orgUnit" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>

							<div class="form-group">
								<label for="_installation" class="col-sm-4 col-md-4 control-label">Installation:</label>
								<div class="col-sm-7 col-md-6">
									<asp:DropDownList ID="_installation" CssClass="form-control" runat="server" Text='<%# Bind("Installation") %>' AppendDataBoundItems="True">
										<asp:ListItem Text="-- Select Installation --" Value="" />
									</asp:DropDownList>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_installationRequiredValidator" runat="server" ErrorMessage="Installation: Please select your installation." ControlToValidate="_installation" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>

							<div class="form-group">
								<label for="_bldgNum" class="col-sm-4 col-md-4 control-label">Bldg Number:</label>
								<div class="col-sm-7 col-md-6">
									<asp:TextBox ID="_bldgNum" CssClass="form-control" runat="server" Text='<%# Bind("Bldg") %>' />
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_bldgRequiredValidator" runat="server" ErrorMessage="Bldg. Number: Please enter your Building Number." ControlToValidate="_bldgNum" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="_bldgExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="Bldg: Please enter numbers only." Text="Requires your attention." ControlToValidate="_bldgNum" Display="Dynamic" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
								</div>
							</div>
				
							<div class="form-group">
								<label for="_roomNum" class="col-sm-4 col-md-4 control-label">Room Number:</label>
								<div class="col-sm-7 col-md-6">
									<asp:TextBox ID="_roomNum" CssClass="form-control" runat="server" Text='<%# Bind("Room") %>' />
									<asp:RegularExpressionValidator ID="_roomExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="Room number: Please enter numbers only." Text="Requires your attention." ControlToValidate="_roomNum" Display="Dynamic" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
								</div>
							</div>
				
							<div class="form-group">
								<label for="_office" class="col-sm-4 col-md-4 control-label">Office/Company:</label>
								<div class="col-sm-7 col-md-6">
									<asp:TextBox ID="_office" CssClass="form-control" runat="server" Text='<%# Bind("Office") %>' />
								</div>
							</div>

							<div class="form-group">
								<label for="_phone" class="col-sm-4 col-md-4 control-label">Work Phone Number:</label>
								<div class="col-sm-7 col-md-6">
									<asp:TextBox placeholder="000-000-0000" ID="_phone" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' />
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_phoneRequiredValidator" runat="server" ErrorMessage="Office Phone Number: Please enter your office number." ControlToValidate="_phone" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="label label-warning" ControlToValidate="_phone" runat="server" ErrorMessage="Phone: Please enter a valid number in the format of 000-000-0000." Display="Dynamic" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}">Requires your attention.</asp:RegularExpressionValidator>
								</div>
							</div>

							<asp:Panel ID="_niprPanel" Visible="false" runat="server">
								<h4 class="page-header">Awareness Training</h4>
								<div class="form-group">
									<div class="col-sm-12 col-md-offset-1 col-md-11">
										<div class="checkbox">
											<label>
												<asp:CheckBox ID="_trainingCheck" runat="server" />
												I have completed the Annual Information Awareness Training.
											</label>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="_trainingDate" class="col-sm-4 col-md-4 control-label">Date Completed:</label>
									<div class="col-sm-7 col-md-6">									
										<div id="datePicker" class="input-group date">
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
											<asp:TextBox ID="_trainingDate" CssClass="form-control" Enabled="false" runat="server" />
										  
										</div>
									</div>
								</div>
							</asp:Panel>

							<asp:Panel ID="_epPanel" Visible="false" runat="server">
								<h4 class="page-header">EP Section</h4>
								<div class="form-group">
									<label for="_epUnitsList" class="col-sm-4 col-md-4 control-label">EP Unit List:</label>
									<div class="col-sm-7 col-md-6">
										<asp:ListBox ID="_epUnitsList" Rows="8" CssClass="form-control" ClientIDMode="Static" SelectionMode="Multiple" runat="server">
											<asp:ListItem Text="-- Select Units --" Value="" />
										</asp:ListBox>
										<span class="help-block">Hold the Ctrl button on your keyboard to make multiple selections.</span>
									</div>
								</div>
								<div class="form-group">
									<label for="_epSelectedUnits" class="col-sm-4 col-md-4 control-label">EP Selected Units:</label>
									<div class="col-sm-7 col-md-6">
										<asp:TextBox ID="_epSelectedUnits" Rows="4" TextMode="MultiLine" CssClass="form-control" ClientIDMode="Static" Text='<%# Bind("EpUnits") %>' runat="server" />
										<span class="help-block">Use the EP Units list above to populate this field.</span>
										<asp:RequiredFieldValidator CssClass="label label-warning" ID="_epUnitsRequiredValidator" runat="server" ErrorMessage="Selected Units: Please enter the units you want to have elevated privelages over." ControlToValidate="_epSelectedUnits" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									</div>
								</div>
							</asp:Panel>
						</div> <%-- End .panel-body --%>
						<div class="panel-footer">
							<asp:Button ID="_submitBtn" data-loading-text="Validating information..." runat="server" Text="Submit" CommandName="Insert" CssClass="btn btn-primary" />
							<asp:Button ID="_cancelBtn" runat="server" CommandName="Cancel" Text="Reset form" CausesValidation="False" CssClass="btn btn-default" />
						</div>
					</div>
				</div><%-- End left column --%> 

				<div class="col-sm-5">
					<asp:ValidationSummary CssClass="alert alert-danger" ID="_validationSummary" runat="server" />
				</div>
			</div>

			<div class="hidden">
				<asp:RadioButton ID="_niprAcct" Enabled="false" Text="&nbsp;NIPR" runat="server" GroupName="RequestType" Checked='<%# Bind("Nipr") %>' />
				<asp:RadioButton ID="_siprAcct" Enabled="false" Text="&nbsp;SIPR" runat="server" GroupName="RequestType" Checked='<%# Bind("Sipr") %>' />
				<asp:RadioButton ID="_epAcct" Enabled="false" Text="&nbsp;EP" runat="server" GroupName="RequestType" Checked='<%# Bind("NiprEp") %>' />
				<asp:RadioButton ID="_vpnAcct" Enabled="false" Text="&nbsp;VPN" runat="server" GroupName="RequestType" Checked='<%# Bind("Vpn") %>' />
				<asp:CheckBox ID="_supSigned" Enabled="false" Checked='<%# Bind("SupSigned") %>' runat="server" />
				<asp:CheckBox ID="_secSigned" Enabled="false" Checked='<%# Bind("SecSigned") %>' runat="server" />
				<asp:TextBox ID="_requestType" Enabled="false" Text='<%# Bind("RequestType") %>' runat="server" />
				<asp:TextBox ID="_accountType" Enabled="false" Text='<%# Bind("AccountType") %>' runat="server" />
				<asp:TextBox ID="_acctStatus" Enabled="false" Text='<%# Bind("AcctStatus") %>' runat="server" />
				<asp:TextBox ID="_date" Enabled="false" Text='<%# Bind("RequestedDate") %>' runat="server"></asp:TextBox>
			</div>

		</InsertItemTemplate>
	</asp:FormView>
							
	<asp:EntityDataSource ID="_formviewEntitySource" 
		runat="server" 
		ConnectionString="name=CarsonAccountEntities" 
		DefaultContainerName="CarsonAccountEntities" 
		EnableFlattening="False" 
		EnableInsert="True" 
		EntitySetName="AccountRequests">
	</asp:EntityDataSource>

</asp:Content>

<asp:Content ID="_childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
	<script src="_assets/js/bootstrap-datepicker.js"></script>
</asp:Content>
