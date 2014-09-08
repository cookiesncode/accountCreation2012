<%@ Page Title="Request Form" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="request-account.aspx.cs" MaintainScrollPositionOnPostback="true" Inherits="AccountCreation.RequestAccount" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	<h2 class="page-header">Request Form</h2>	
	<asp:Panel ID="_createNiprFail" runat="server" Visible="false">
        <div class="well">
		    <p>We’re sorry, but our records indicate that you already have a NIPR account with a display name of <strong><asp:Label ID="_niprName" runat="server" CssClass="text-warning"></asp:Label></strong>. This account could be from your previous installation and in order for you to create a Fort Carson account, you need to delete your existing one. To delete this account, call AESD at 1-866-335-2769 and request an account deletion.</p>
        </div>
	</asp:Panel>

	<asp:Panel ID="_createVpnFail" runat="server" Visible="false">
        <div class="well">
		    <p>Our records indicate that you already have a VPN account. The name of the VPN group you reside in is <strong><asp:Label ID="_vpnGroup" runat="server" CssClass="text-warning"></asp:Label></strong></p>
        </div>
	</asp:Panel>

	<asp:Panel ID="_createSpecialAcctFail" runat="server" Visible="false">
        <div class="well">
            <p>Our records indicate that you don't have a Fort Carson NIPR account. In order for you to create an account either than NIPR, you must have an existing NIPR account.</p>
        </div>
	</asp:Panel>

    <asp:Panel ID="_deleteNiprFail" runat="server" Visible="false">
        <div class="well">
		    <p>Our records indicate that you don't have a Fort Carson NIPR account. So there is nothing to delete.</p>
        </div>
	</asp:Panel>

    <asp:Panel ID="_deleteVpnFail" runat="server" Visible="false">
        <div class="well">
		    <p>Our records indicate that you don't have a Fort Carson VPN account. So there is nothing to delete.</p>
        </div>
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
							<p class="lead">Please fill out this form.</p>
							<p><strong class="text-info">Note:</strong> The EDIPI, last name, first name, and middle initial are pre-populated from your CAC card.</p>
                            <p>If the information populated is not correct, then try closing and opening your browser and start again.</p>
						</div>
						<div class="panel-body">
                            <h4 class="page-header">Personal Information</h4>
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
								</div>
							</div>

							<div class="form-group">
								<label for="_email" class="col-sm-4 col-md-4 control-label">NIPR Enterprise Email:</label>
								<div class="col-sm-7 col-md-6">
									<asp:TextBox ID="_email" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' />
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_emailRequiredValidator" runat="server" ErrorMessage="Email: Please enter your enterprise email address." ControlToValidate="_email" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="_emailExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="Email: Please enter a valid email address." Display="Dynamic" ControlToValidate="_email" Text="Requires your attention." ValidationExpression="\w+([-+.']\w+)*@mail.mil"></asp:RegularExpressionValidator>
                                     <a href="_assets/docs/find-email-guide.pdf" class="js-persona-link" target="_blank" title="Help locate your email"><span class="glyphicon glyphicon-info-sign"></span></a>
								</div>
							</div>

							<div class="form-group js-persona">
								<label for="_persona" class="col-sm-4 col-md-4 control-label">Persona Type:</label>
								<div class="col-sm-7 col-md-6">
									<asp:DropDownList ID="_persona" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Persona") %>' AppendDataBoundItems="True">
										<asp:ListItem Text="-- Select Persona --" Value="" />
									</asp:DropDownList>
                                    <a href="_assets/docs/persona-types.pdf" class="js-persona-link" target="_blank" title="Persona PDF Guide"><span class="glyphicon glyphicon-info-sign"></span></a>
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
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_deptRequiredValidator" runat="server" ErrorMessage="Org/Unit: Please make a selection." ControlToValidate="_orgUnit" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
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
									<asp:TextBox ID="_phone" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' />
                                    <span class="help-block">Format: XXX.XXX.XXXX</span>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_phoneRequiredValidator" runat="server" ErrorMessage="Office Phone Number: Please enter your office number." ControlToValidate="_phone" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="_phoneExpressionValidator" CssClass="label label-warning" ControlToValidate="_phone" runat="server" ErrorMessage="Phone: Please enter a valid Fort Carson number, i.e., 719.526/524/503.XXXX" Display="Dynamic" ValidationExpression="719\.(526|524|503)\.\d{4}">Requires your attention.</asp:RegularExpressionValidator>
								</div>
							</div>

                            <asp:Panel ID="_siprSection" Visible="false" runat="server">
							    <div class="form-group">
								    <label for="_siprToken" class="col-sm-4 col-md-4 control-label">SIPR Token Number:</label>
								    <div class="col-sm-7 col-md-6">
                                        <div class="input-group">
                                            <span class="input-group-addon">534E-</span>
									        <asp:TextBox ID="_siprToken" CssClass="form-control" runat="server" Text='<%# Bind("SiprToken") %>' />
                                        </div>
                                        <span class="help-block">Format: XXXX-XXXX-XXXX <br />(Leave blank if none)</span>
									<asp:RegularExpressionValidator ID="_siprExpressionValidator" CssClass="label label-warning" ControlToValidate="_siprToken" runat="server" ErrorMessage="SIPR Token: Please enter a valid SIPR token, i.e., 719.526/524/503.XXXX" Display="Dynamic" ValidationExpression="\d{4}\-\d{4}\-\d{4}">Requires your attention.</asp:RegularExpressionValidator>
								    </div>
							    </div>
                            </asp:Panel>

                            <asp:Panel ID="_deleteRequestPanel" Visible="false" runat="server">
								<div class="form-group">
									<label for="_deleteDate" class="col-sm-4 col-md-4 control-label">Requested Delete Date:</label>
									<div class="col-sm-7 col-md-6">									
										<div data-js-datepicker="delete-date" class="input-group date">
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
											<asp:TextBox ID="_deleteDate" Text='<%# Bind("DeleteDate") %>' Enabled="false" CssClass="form-control" runat="server" />
										</div>
                                        <span class="help-block">You can not select a date more than 2 months out from today.</span>
                                        <asp:RequiredFieldValidator CssClass="label label-warning" ID="_deleteDateRequiredValidator" runat="server" ErrorMessage="Requested Delete Date: Please enter your the date you want your account to be deleted." ControlToValidate="_deleteDate" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RangeValidator ID="_deleteDateRangeValidator" runat="server" ErrorMessage="Requested Delete Date: The training date is out of the accepted range." Text="Requires your attention." Display="Dynamic" ControlToValidate="_deleteDate" CssClass="label label-warning"></asp:RangeValidator>
									</div>
								</div>
                            </asp:Panel>

                            <asp:Panel ID="_justificationPanel" runat="server" Visible="false">
                                <div class="form-group">
								    <label for="_justification" class="col-sm-4 col-md-4 control-label">Justification:</label>
								    <div class="col-sm-7 col-md-6">
									    <asp:TextBox ID="_justification" TextMode="MultiLine" Rows="5" CssClass="form-control" runat="server" Text='<%# Bind("Justification") %>' />
                                        <span class="help-block">Write a short summary explaining your <em>need</em> for this account</span>
									    <asp:RequiredFieldValidator CssClass="label label-warning" ID="_justificationRequiredValidator" runat="server" ErrorMessage="Justification: Please fill out your justification for this account." ControlToValidate="_justification" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								    </div>
							    </div>
                            </asp:Panel>

							<asp:Panel ID="_trainingPanel" Visible="false" runat="server">
								<h4 class="page-header">DoD Cyber Awareness Training</h4>
                                <p>You must have completed the DoD Cyber Awareness Training within the last year. If you have not, take the training here: <a href="https://ia.signal.army.mil/DoDIAA/default.asp" target="new">DoD Cyber Awareness Training  <span title="New Window" class="glyphicon glyphicon-new-window"></span></a>.</p>
								<div class="form-group">
									<div class="col-sm-12">
										<div class="checkbox">
											<label>
                                                <asp:CheckBox ID="_trainingCheckBox" Checked='<%# Bind("Training") %>' ClientIDMode="Static" runat="server" />
                                                <asp:TextBox ID="_trainingTextBox" ClientIDMode="Static" CssClass="hidden" runat="server"></asp:TextBox>
												I have completed the DoD Cyber Awareness Training.
											</label>
										</div>
                                        <asp:RequiredFieldValidator CssClass="label label-warning" ID="_trainingRequiredValidator" runat="server" ErrorMessage="Training: You must have completed the DoD Cyber Awareness Training." ControlToValidate="_trainingTextBox" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									</div>
								</div>

								<div id="_trainingDatePanel" class="form-group">
									<label for="_trainingDate" class="col-sm-4 col-md-4 control-label">Date Completed:</label>
									<div class="col-sm-7 col-md-6">									
										<div data-js-datepicker="training-date" class="input-group date">
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
											<asp:TextBox ID="_trainingDate" Text='<%# Bind("TrainingDate") %>' Enabled="false" CssClass="form-control" runat="server" />
										</div>
                                        <asp:RequiredFieldValidator CssClass="label label-warning" ID="_trainingDateRequiredValidator" runat="server" ErrorMessage="Date Completed: Please enter your certification date." ControlToValidate="_trainingDate" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RangeValidator ID="_trainingDateRangeValidator" runat="server" ErrorMessage="Date Completed: The training date is out of the accepted range." Text="Requires your attention." Display="Dynamic" ControlToValidate="_trainingDate" CssClass="label label-warning"></asp:RangeValidator>
									</div>
								</div>
							</asp:Panel>

							<asp:Panel ID="_saPanel" Visible="false" runat="server">
								<h4 class="page-header">SA Section</h4>
								<div class="form-group">
									<label for="_commanderName" class="col-sm-4 col-md-4 control-label">Commander's Name:</label>
									<div class="col-sm-7 col-md-6">
										<asp:TextBox ID="_commanderName" CssClass="form-control" Text='<%# Bind("CommanderName") %>' runat="server" />
										<asp:RequiredFieldValidator CssClass="label label-warning" ID="_commanderRequiredValidator" runat="server" ErrorMessage="Commander's Name: Please enter your commander's name." ControlToValidate="_commanderName" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									</div>
								</div>
								<div class="form-group">
									<label for="_mos" class="col-sm-4 col-md-4 control-label"><abbr class="initialism" title="Military Occupational Specialty">MOS</abbr> / Job Title:</label>
									<div class="col-sm-7 col-md-6">
										<asp:TextBox ID="_mos" CssClass="form-control" Text='<%# Bind("Mos") %>' runat="server" />
										<asp:RequiredFieldValidator CssClass="label label-warning" ID="_mosRequiredValidator" runat="server" ErrorMessage="MOS: Please enter you MOS." ControlToValidate="_mos" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									</div>
								</div>
								<div class="form-group">
									<label for="_unitList" class="col-sm-4 col-md-4 control-label">Unit List:</label>
									<div class="col-sm-7 col-md-6">
										<asp:ListBox ID="_unitList" Rows="8" CssClass="form-control" ClientIDMode="Static" SelectionMode="Multiple" runat="server">
											<asp:ListItem Text="-- Select Units --" Value="" />
										</asp:ListBox>
										<span class="help-block">Hold the Ctrl button on your keyboard to make multiple selections.</span>
									</div>
								</div>
								<div class="form-group">
									<label for="_selectedUnits" class="col-sm-4 col-md-4 control-label">Units Selected:</label>
									<div class="col-sm-7 col-md-6">
										<asp:TextBox ID="_selectedUnits" Rows="4" TextMode="MultiLine" CssClass="form-control" ClientIDMode="Static" Text='<%# Bind("EpUnits") %>' runat="server" />
										<span class="help-block">Use the Unit list above to populate this field. These are the units your are requesting to have admin. rights.</span>
										<asp:RequiredFieldValidator CssClass="label label-warning" ID="_saUnitsRequiredValidator" runat="server" ErrorMessage="Selected Units: Please enter the units you want to have elevated privelages over." ControlToValidate="_selectedUnits" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
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
				<asp:RadioButton ID="_niprAcct" Text="&nbsp;NIPR" runat="server" GroupName="RequestType" Checked='<%# Bind("Nipr") %>' />
				<asp:RadioButton ID="_siprAcct" Text="&nbsp;SIPR" runat="server" GroupName="RequestType" Checked='<%# Bind("Sipr") %>' />
				<asp:RadioButton ID="_epAcct" Text="&nbsp;EP" runat="server" GroupName="RequestType" Checked='<%# Bind("NiprEp") %>' />
				<asp:RadioButton ID="_saAcct" Text="&nbsp;SA" runat="server" GroupName="RequestType" Checked='<%# Bind("NiprSa") %>' />
				<asp:RadioButton ID="_vpnAcct" Text="&nbsp;VPN" runat="server" GroupName="RequestType" Checked='<%# Bind("Vpn") %>' />
				<asp:CheckBox ID="_supSigned" Checked='<%# Bind("SupSigned") %>' runat="server" />
				<asp:CheckBox ID="_secSigned" Checked='<%# Bind("SecSigned") %>' runat="server" />
				<asp:CheckBox ID="_iaSigned" Checked='<%# Bind("IaSigned") %>' runat="server" />
				<asp:CheckBox ID="_dsdSigned" Checked='<%# Bind("DsdSigned") %>' runat="server" />
				<asp:CheckBox ID="_saSigned" Checked='<%# Bind("SaSigned") %>' runat="server" />
				<asp:TextBox ID="_requestType" Text='<%# Bind("RequestType") %>' runat="server" />
				<asp:TextBox ID="_macom" ClientIDMode="Static" Text='<%# Bind("Macom") %>' runat="server" />
				<asp:TextBox ID="_accountType" Text='<%# Bind("AccountType") %>' runat="server" />
				<asp:TextBox ID="_requestStatus" Text='<%# Bind("RequestStatus") %>' runat="server" />
				<asp:TextBox ID="_date" Text='<%# Bind("RequestedDate") %>' runat="server"></asp:TextBox>
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
