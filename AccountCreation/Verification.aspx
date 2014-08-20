<%@ Page Title="Existing Request" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="verification.aspx.cs" Inherits="AccountCreation.Verification" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	
	<h2 class="page-header">Existing Request</h2>
	
	<asp:Panel ID="_searchPanel" CssClass="search-panel buffer" DefaultButton="_searchButton" runat="server">
		<p class="lead">You can search by the <abbr class="initialism" title="Electronic Data Interchange Personal Identifier">EDIPI</abbr> number, or last name, or first name.</p>
		<p><strong class="text-info">Note:</strong> Searching by <abbr class="initialism" title="Electronic Data Interchange Personal Identifier">EDIPI</abbr> gives you more accurate results.</p>	
		<div class="form-group">
			<div class="col-xs-6 col-sm-5 col-md-4 col-lg-3">
				<div class="input-group">
					<asp:TextBox CssClass="form-control" ID="_searchBox" runat="server" ValidationGroup="_searchValidationGroup"></asp:TextBox>
					<span class="input-group-btn">
						<asp:Button data-loading-text="Searching..." ID="_searchButton" CausesValidation="true" CssClass="btn btn-primary" ValidationGroup="_searchValidationGroup" runat="server" Text="Search" OnClick="_searchButton_Click" />
					</span>
				</div>
				<asp:RequiredFieldValidator ID="_searchRequiredValidator" runat="server" ErrorMessage="Enter your search criteria" Display="Dynamic" CssClass="label label-warning" ControlToValidate="_searchBox" ValidationGroup="_searchValidationGroup"></asp:RequiredFieldValidator>
			</div>
		</div>
	</asp:Panel>
	
	<div class="panel panel-default buffer">
		<div class="panel-heading"><h3>Search Results</h3></div>
		<div class="table-responsive">
			<%-- TODO: Style paging generated controls --%>
			<asp:GridView ID="_gridview" runat="server" 
				CssClass="table table-condensed table-hover"
				SelectedRowStyle-CssClass="active"
				DataKeyNames="Id" 
				DataSourceID="_gridEntitySource" 
				GridLines="None"
				AllowPaging="True" 
				AutoGenerateColumns="False" 
				AllowSorting="True" 
				OnSelectedIndexChanged="_gridview_SelectedIndexChanged"
				Visible="False" 
				EmptyDataText="No results found" 
				EnablePersistedSelection="True" 
				OnPageIndexChanged="_gridview_PageIndexChanged" 
                PagerStyle-CssClass="table-pagination">
				<Columns>
					<asp:CommandField ShowSelectButton="True"></asp:CommandField>
					<asp:BoundField DataField="Edipi" HeaderText="EDIPI" SortExpression="Edipi" />
					<asp:BoundField DataField="LName" HeaderText="Last Name" SortExpression="LName" />
					<asp:BoundField DataField="FName" HeaderText="First Name" SortExpression="FName" />
					<asp:BoundField DataField="Mi" HeaderText="Mi" SortExpression="Mi" />
					<asp:BoundField DataField="Rank" HeaderText="Rank" SortExpression="Rank" />
					<asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
					<asp:BoundField DataField="OrgUnit" HeaderText="Org/Unit" SortExpression="OrgUnit" />
					<asp:BoundField DataField="AccountType" HeaderText="Account Type" SortExpression="AccountType" />
					<asp:BoundField DataField="RequestType" HeaderStyle-CssClass="js-popover-request" HeaderText="Request Type" SortExpression="RequestType" />
					<asp:BoundField DataField="RequestStatus" HeaderStyle-CssClass="js-popover-status" HeaderText="Request Status" SortExpression="RequestStatus" />
				</Columns>
				<SelectedRowStyle CssClass="active"></SelectedRowStyle>
			</asp:GridView>
		</div>
	</div>
	
	<asp:FormView ID="_formview" runat="server"
		RenderOuterTable="False"
		DataKeyNames="Id"
		DataSourceID="_formviewEntitySource"
		OnDataBound="_formview_DataBound"
		DefaultMode="Edit"
		Visible="false" 
		OnItemUpdated="_formview_ItemUpdated">
		
		<EditItemTemplate>
			<div class="row">
				<%-- Start left column --%>
				<div class="col-sm-6">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3>Request Entry</h3>
							<small>Please verify this information is correct and then add your appropriate signature.</small>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label for="_edipi" class="col-sm-4 control-label">EDIPI:</label>
								<div class="col-sm-8">
									<asp:TextBox ID="_edipi"  Enabled="false" CssClass="form-control" runat="server" Text='<%# Eval("Edipi") %>'  />
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_edipiRequiredValidator" runat="server" ErrorMessage="EDIPI: Please enter your EDIPI number." ControlToValidate="_edipi" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>

							<div class="form-group">
								<label for="_lName" class="col-sm-4 control-label">Last Name:</label>
								<div class="col-sm-8">
									<asp:TextBox ID="_lName" CssClass="form-control" Enabled="false" runat="server" Text='<%# Eval("LName") %>' />
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_lNameRequiredValidator" runat="server" ErrorMessage="Last name: Please enter your last name." ControlToValidate="_lName" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>

							<div class="form-group">
								<label for="_fName" class="col-sm-4 control-label">First Name:</label>
								<div class="col-sm-8">
									<asp:TextBox ID="_fName" CssClass="form-control" Enabled="false" runat="server" Text='<%# Eval("FName") %>' />
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_fNameRequiredValidator" runat="server" ErrorMessage="First name: Please enter your first name." ControlToValidate="_fName" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>
				
							<div class="form-group">
								<label for="_middleInitial" class="col-sm-4 control-label">MI:</label>
								<div class="col-sm-3">
									<asp:TextBox ID="_middleInitial" CssClass="form-control" runat="server" Text='<%# Bind("Mi") %>' />
								</div>
							</div>

							<div class="form-group">
								<label for="_email" class="col-sm-4 control-label">NIPR Enterprise Email:</label>
								<div class="col-sm-8">
									<asp:TextBox ID="_email" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' />
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_emailRequiredValidator" runat="server" ErrorMessage="Enterprise Email: Please enter your enterprise email address." ControlToValidate="_email" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="_emailExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="Enterprise Email: Please enter a valid email address." Display="Dynamic" ControlToValidate="_email" Text="Requires your attention." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
								</div>
							</div>

							<div class="form-group">
								<label for="_persona" class="col-sm-4 control-label">Persona Type:</label>
								<div class="col-sm-8">
									<asp:DropDownList ID="_persona" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Persona") %>' DataSourceID="_formviewEntitySource" DataTextField="Persona" DataValueField="Persona">
										<asp:ListItem Text="-- Select Persona --" Value="" />
									</asp:DropDownList>
                                    <a href="_assets/docs/persona-types.pdf" class="js-persona-link" target="new" title="Persona PDF Guide"><span class="glyphicon glyphicon-info-sign"></span></a>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_personaRequiredValidator" runat="server" ErrorMessage="Persona: Please select a Persona." ControlToValidate="_persona" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>

							<div class="form-group">
								<label for="_rank" class="col-sm-4 control-label">Rank:</label>
								<div class="col-sm-8">
									<asp:DropDownList ID="_Rank" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Rank") %>' DataSourceID="_formviewEntitySource" DataTextField="Rank" DataValueField="Rank" AppendDataBoundItems="True">
										<asp:ListItem Text="-- Select Rank --" Value="" />
									</asp:DropDownList>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_rankRequiredValidator" runat="server" ErrorMessage="Rank: Please select your rank." ControlToValidate="_rank" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>
	
							<div class="form-group">
								<label for="_macom" class="col-sm-4 control-label">MACOM:</label>
								<div class="col-sm-8">
									<asp:DropDownList ID="_macom" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Macom") %>' DataSourceID="_formviewEntitySource" DataTextField="Macom" DataValueField="Macom" AppendDataBoundItems="True">
										<asp:ListItem Text="-- Select a MACOM --" Value="" />
									</asp:DropDownList>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_macomRequiredValidator" runat="server" ErrorMessage="MACOM: Please select an option." ControlToValidate="_macom" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>
							
							<div class="form-group">
								<label for="_branch" class="col-sm-4 control-label">Branch:</label>
								<div class="col-sm-8">
									<asp:DropDownList ID="_branch" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Branch") %>' DataSourceID="_formviewEntitySource" DataTextField="Branch" DataValueField="Branch" AppendDataBoundItems="True">
										<asp:ListItem Text="-- Select a Branch --" Value="" />
									</asp:DropDownList>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_branchRequiredValidator" runat="server" ErrorMessage="Branch: Please select your branch." ControlToValidate="_branch" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>
							
							<div class="form-group">
								<label for="_orgUnit" class="col-sm-4 control-label">Org/Unit:</label>
								<div class="col-sm-8">
									<asp:DropDownList ID="_orgUnit" CssClass="form-control" runat="server" SelectedValue='<%# Bind("OrgUnit") %>' DataSourceID="_formviewEntitySource" DataTextField="OrgUnit" DataValueField="OrgUnit" AppendDataBoundItems="True">
										<asp:ListItem Text="-- Select a Org/Unit --" Value="" />
									</asp:DropDownList>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_orgUnitRequiredValidator" runat="server" ErrorMessage="Org/Unit: Please select your Org/Unit." ControlToValidate="_orgUnit" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>
					
							<div class="form-group">
								<label for="_installation" class="col-sm-4 control-label">Installation:</label>
								<div class="col-sm-8">
									<asp:DropDownList ID="_installation" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Installation") %>' DataSourceID="_formviewEntitySource" DataTextField="Installation" DataValueField="Installation" AppendDataBoundItems="True">
										<asp:ListItem Text="-- Select Installation --" Value="" />
									</asp:DropDownList>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_installationRequiredValidator" runat="server" ErrorMessage="Installation: Please select your installation." ControlToValidate="_installation" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								</div>
							</div>
		
							<div class="form-group">
								<label for="_bldgNum" class="col-sm-4 control-label">Bldg. Number:</label>
								<div class="col-sm-8">
									<asp:TextBox ID="_bldgNum" CssClass="form-control" runat="server" Text='<%# Bind("Bldg") %>' />
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_bldgRequiredValidator" runat="server" ErrorMessage="Bldg. Number: Please enter your Building Number." ControlToValidate="_bldgNum" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="_bldgExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="Bldg: Please enter numbers only." Text="Requires your attention." ControlToValidate="_bldgNum" Display="Dynamic" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
								</div>
							</div>
				
							<div class="form-group">
								<label for="_roomNum" class="col-sm-4 control-label">Room Number:</label>
								<div class="col-sm-8">
									<asp:TextBox ID="_roomNum" CssClass="form-control" runat="server" Text='<%# Bind("Room") %>' />
									<asp:RegularExpressionValidator ID="_roomExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="Room number: Please enter numbers only." Text="Requires your attention." ControlToValidate="_roomNum" Display="Dynamic" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
								</div>
							</div>
				
							<div class="form-group">
								<label for="_office" class="col-sm-4 control-label">Office/Company:</label>
								<div class="col-sm-8">
									<asp:TextBox ID="_office" CssClass="form-control" runat="server" Text='<%# Bind("Office") %>' />
								</div>
							</div>

							<div class="form-group">
								<label for="_phone" class="col-sm-4 control-label">Phone Number:</label>
								<div class="col-sm-8">
									<asp:TextBox ID="_phone" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' />
                                    <span class="help-block">Format: 000.000.0000</span>
									<asp:RequiredFieldValidator CssClass="label label-warning" ID="_phoneRequiredValidator" runat="server" ErrorMessage="Office Phone Number: Please enter your office number." ControlToValidate="_phone" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="_phoneExpressionValidator" CssClass="label label-warning" ControlToValidate="_phone" runat="server" ErrorMessage="Phone: Please enter a valid Fort Carson number, i.e., 719.526/524/503.XXXX" Display="Dynamic" ValidationExpression="719\.(526|524|503)\.\d{4}">Requires your attention.</asp:RegularExpressionValidator>
								</div>
							</div>

                            <asp:Panel ID="_deleteRequestPanel" Visible="false" runat="server">
								<div class="form-group">
									<label for="_deleteDate" class="col-sm-4 col-md-4 control-label">Requested Delete Date:</label>
									<div class="col-sm-7 col-md-6">									
										<div data-js-datepicker="delete-date" class="input-group date">
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
											<asp:TextBox ID="_deleteDate" Text='<%# Bind("DeleteDate", "{0:d}") %>' Enabled="false" CssClass="form-control" runat="server" />
										</div>
                                        <span class="help-block">You can not select a date more than 2 months out from today.</span>
                                        <asp:RequiredFieldValidator CssClass="label label-warning" ID="_deleteDateRequiredValidator" runat="server" ErrorMessage="Requested Delete Date: Please enter your the date you want your account to be deleted." ControlToValidate="_deleteDate" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RangeValidator ID="_deleteDateRangeValidator" runat="server" ErrorMessage="Requested Delete Date: The training date is out of the accepted range." Text="Requires your attention." Display="Dynamic" ControlToValidate="_deleteDate" CssClass="label label-warning"></asp:RangeValidator>
									</div>
								</div>
                            </asp:Panel>
                            
                            <asp:Panel ID="_justificationPanel" runat="server" Visible="false">
                                 <div class="form-group">
								    <label for="_justification" class="col-sm-4 control-label">Justification:</label>
								    <div class="col-sm-8">
									    <asp:TextBox ID="_justification" TextMode="MultiLine" Rows="5" CssClass="form-control" runat="server" Text='<%# Bind("Justification") %>' />
                                        <span class="help-block">Write a short summary explaining your <em>need</em> for this account</span>
									    <asp:RequiredFieldValidator CssClass="label label-warning" ID="_justificationRequiredValidator" runat="server" ErrorMessage="Justification: Please fill out your justification for this account." ControlToValidate="_justification" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
								    </div>
							    </div>
                           </asp:Panel>                                

							<asp:Panel ID="_saPanel" Visible="false" runat="server">
								<h4 class="page-header">SA Section</h4>
								<div class="form-group">
									<label for="_mos" class="col-sm-4 col-md-4 control-label"><abbr class="initialism" title="Military Occupational Specialty">MOS</abbr>:</label>
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
										<span class="help-block">Use the Unit list above to populate this field.</span>
										<asp:RequiredFieldValidator CssClass="label label-warning" ID="_epUnitsRequiredValidator" runat="server" ErrorMessage="Selected Units: Please enter the units you want to have elevated privelages over." ControlToValidate="_selectedUnits" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									</div>
								</div>
							</asp:Panel>
						</div>
                        <%-- End panel body --%>
					</div>
				</div>
				<%-- End left column --%>

				<%-- Start right column --%>
				<div class="col-sm-6">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3>Supervisor Approval</h3>
							<small>Please fix any incorrect information in the <em>Request Entry</em> before signing the form.</small>
						</div>
						<div class="panel-body">
                            <p class="text-danger"><strong>I verify this user's request as provided:</strong></p>
							<div class="form-group">
								<label for="_supervisorCheckBox" class="col-sm-4 control-label">Supervisor:</label>
								<div class="col-sm-8">
									<div class="input-group">
										<span class="input-group-addon">
											<asp:CheckBox ID="_supervisorCheckBox" runat="server" Checked='<%# Bind("SupSigned") %>' OnCheckedChanged="_supervisor_CheckBox_CheckedChanged" AutoPostBack="True" />
										</span>
										<asp:TextBox ID="_supervisorSignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("SupEdipi") %>' />
									</div>
                                    <small class="help-block">Check the box to apply your signature.</small>
									<asp:RequiredFieldValidator ID="_supSignRequiredValidator" runat="server" ErrorMessage="Supervisor signature: You must sign the form before applying your changes." Text="Requires your attention" Display="Dynamic" CssClass="label label-warning" ControlToValidate="_supervisorSignature"></asp:RequiredFieldValidator>
									<asp:CompareValidator ID="_requestorSupervisorCompareValidator" ControlToCompare="_edipi" runat="server" ErrorMessage="Supervisor signature: The Request entry EDIPI and the Supervisor signature can not be the same." CssClass="label label-warning" Display="Dynamic" Text="Requires your attention" ControlToValidate="_supervisorSignature" Operator="NotEqual"></asp:CompareValidator>
								</div>
							</div>
                        </div>
                        <asp:PlaceHolder Visible="false" ID="_securityBoxPlaceholder" runat="server">
                            <div class="panel-heading">
                                <h3>Security Manager Approval</h3>
                            </div>
                            <div class="panel-body">	
								<div class="form-group">
									<label for="_investigationType" class="col-sm-5 control-label">Investigation Type:</label>
									<div class="col-sm-7">
										<asp:TextBox ID="_investigationType" CssClass="form-control" ClientIDMode="Static" Text='<%# Bind("InvestigationType") %>' runat="server" />
										<asp:RequiredFieldValidator CssClass="label label-warning" ID="_investigationTypeRequiredValidator" runat="server" ErrorMessage="Type of Investigation: Please fill out the investigation type." ControlToValidate="_investigationType" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									</div>
								</div>
								<div id="_investigationDatePanel" class="form-group">
									<label for="_investigationDate" class="col-sm-5 control-label">Investigation Date:</label>
									<div class="col-sm-7">									
										<div data-js-datepicker="investigation-date" class="input-group date">
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
											<asp:TextBox ID="_investigationDate" Text='<%# Bind("InvestigationDate", "{0:d}") %>' Enabled="false" CssClass="form-control" runat="server" />
										</div>
                                        <asp:RequiredFieldValidator CssClass="label label-warning" ID="_investigationDateRequiredValidator" runat="server" ErrorMessage="Investigation Date: You must fill out the date." ControlToValidate="_investigationDate" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RangeValidator ID="_investigationDateRangeValidator" runat="server" ErrorMessage="Investigation Date: The date you selected is out of the accepted range." Text="Requires your attention." Display="Dynamic" ControlToValidate="_investigationDate" CssClass="label label-warning"></asp:RangeValidator>
									</div>
								</div>
								<div class="form-group">
									<label for="_clearanceLevel" class="col-sm-5 control-label">Clearance Level:</label>
									<div class="col-sm-7">
										<asp:TextBox ID="_clearanceLevel" CssClass="form-control" ClientIDMode="Static" Text='<%# Bind("ClearanceLevel") %>' runat="server" />
										<asp:RequiredFieldValidator CssClass="label label-warning" ID="_clearanceLevelRequiredValidator" runat="server" ErrorMessage="Clearance Level: Please fill out the clearance level." ControlToValidate="_clearanceLevel" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									</div>
								</div>
								<div class="form-group">
									<label for="_investigationLevel" class="col-sm-5 control-label">IT Level Designation:</label>
									<div class="col-sm-7">
                                        <asp:RadioButtonList ID="_investigationLevel" CssClass="radio requestRadio" data-js="hidden-radio" RepeatLayout="Flow" runat="server" SelectedValue='<%# Bind("LevelDesignation") %>'>
                                            <%-- TODO: Make app work withouth first option (Jank) --%>
                                            <asp:ListItem Value="" Enabled="false">Select an option</asp:ListItem>
                                            <asp:ListItem Value="Level I">Level I</asp:ListItem>
                                            <asp:ListItem Value="Level II">Level II</asp:ListItem>
                                            <asp:ListItem Value="Level III">Level III</asp:ListItem>
                                        </asp:RadioButtonList>
										<asp:RequiredFieldValidator CssClass="label label-warning" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Investigation Level: Please select an investigation level." ControlToValidate="_investigationLevel" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									</div>
								</div>
                                <p class="text-danger"><strong>I verify this user has the proper training, security clearance, and understands the security guideline as an authorized user:</strong></p>   						
							    <div class="form-group">
								    <label for="_securityCheckBox" class="col-sm-4 control-label">Security Manager:</label>
								    <div class="col-sm-8">
									    <div class="input-group">
										    <span class="input-group-addon">
											    <asp:CheckBox ID="_securityCheckBox" data-js="remove-disabled" OnCheckedChanged="_security_CheckBox_CheckedChanged" Checked='<%# Bind("SecSigned") %>' runat="server" AutoPostBack="True" />
										    </span>
										    <asp:TextBox ID="_securitySignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("SecEdipi") %>' />
									    </div>
                                        <small class="help-block">Check the box to apply your signature.</small>
									    <asp:CompareValidator ID="_signatureCompareValidator" CssClass="label label-warning" ControlToValidate="_securitySignature" ControlToCompare="_supervisorSignature" runat="server" ErrorMessage="Security Manager signature: The Supervisor and Security Manager can not be the same person." Type="String" Operator="NotEqual" Text="Requires your attention" Display="Dynamic"></asp:CompareValidator>
									    <asp:RequiredFieldValidator ID="_secSignRequiredValidator" runat="server" ErrorMessage="Security Manager signature: You must sign the form before applying your changes." Text="Requires your attention" Display="Dynamic" CssClass="label label-warning" ControlToValidate="_securitySignature"></asp:RequiredFieldValidator>
									    <asp:CompareValidator ID="_requestorSecurityCompareValidator" ControlToCompare="_edipi" runat="server" ErrorMessage="Security Manager signature: The Request entry EDIPI and the Security Manager signature can not be the same." CssClass="label label-warning" Display="Dynamic" Text="Requires your attention" ControlToValidate="_securitySignature" Operator="NotEqual"></asp:CompareValidator>
								    </div>
							    </div>					
						    </div>
                        </asp:PlaceHolder>
						<div class="panel-footer">
							<asp:Button ID="_updateButton" data-confirm-modal="WARNING: Your signature is binding and you will be held accountable for this account verification. Are you sure you want to continue?" data-loading-text="Validating information..." CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Update" Text="Verify Request" />
							<asp:Button ID="_cancelButton" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" OnClick="_cancelButton_Click" />
						</div>
					</div> <%-- End Signature block --%>
					<asp:ValidationSummary CssClass="alert alert-danger" ID="_validationSummary" runat="server" />	
				</div>
			</div>
			<div class="hidden">
				<asp:TextBox ID="_supSignedDate" Text='<%# Bind("SupDateSigned") %>' runat="server"></asp:TextBox>
				<asp:CheckBox ID="_supSigned" Checked='<%# Bind("SupSigned") %>' runat="server" />
				<asp:TextBox ID="_secSignedDate" Text='<%# Bind("SecDateSigned") %>' runat="server"></asp:TextBox>
				<asp:CheckBox ID="_secSigned" Checked='<%# Bind("SecSigned") %>' runat="server" />
				<asp:TextBox ID="_requestStatus" Text='<%# Bind("RequestStatus") %>' runat="server"></asp:TextBox>
				<asp:TextBox ID="_accountType" Text='<%# Bind("AccountType") %>' runat="server"></asp:TextBox>
				<asp:TextBox ID="_requestType" Text='<%# Bind("RequestType") %>' runat="server"></asp:TextBox>
			</div>		
		</EditItemTemplate>
		<EmptyDataTemplate>
			<p>No records have been found.</p>
		</EmptyDataTemplate>
	</asp:FormView>

	<asp:EntityDataSource ID="_gridEntitySource" runat="server" 
		ConnectionString="name=CarsonAccountEntities" 
		DefaultContainerName="CarsonAccountEntities" 
		EnableDelete="True" 
		EnableFlattening="False" 
		EnableUpdate="True" 
		EntitySetName="AccountRequests">
	</asp:EntityDataSource>
	
	<asp:QueryExtender ID="_searchQueryExtender" runat="server"
		TargetControlID="_gridEntitySource">		
		<asp:SearchExpression DataFields="LName, FName, Edipi" SearchType="Contains">
			<asp:ControlParameter ControlID="_searchBox" />
		</asp:SearchExpression>
	</asp:QueryExtender>
	
	<asp:EntityDataSource ID="_formviewEntitySource" runat="server" 
		ConnectionString="name=CarsonAccountEntities" 
		DefaultContainerName="CarsonAccountEntities" 
		EnableDelete="True" 
		EnableFlattening="False" 
		EnableUpdate="True" 
		EntitySetName="AccountRequests">
	</asp:EntityDataSource>
	
	<asp:QueryExtender ID="_filterQueryExtender" runat="server"
		TargetControlID="_formviewEntitySource">
		<asp:PropertyExpression>
			<asp:ControlParameter ControlID="_gridview" Name="Id" PropertyName="SelectedDataKey.Value"/>
		</asp:PropertyExpression>	
	</asp:QueryExtender>
</asp:Content>

<asp:Content ID="_childBtmScripts" ContentPlaceHolderID="_masterBtmScripts" runat="server">
	<script src="_assets/js/bootstrap-datepicker.js"></script>
</asp:Content>
