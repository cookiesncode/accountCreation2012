<%@ Page Title="Request Verification" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Verification.aspx.cs" Inherits="AccountCreation.Verification" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	
	<h2 class="page-header">Request Verification</h2>
	
	<asp:Panel ID="_searchPanel" CssClass="search-panel buffer" DefaultButton="_searchButton" runat="server">
		<p class="lead">Please search by the <abbr class="initialism" title="Electronic Data Interchange Personal Identifier">EDIPI</abbr> number, Last name, or First name.</p>
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
				OnPageIndexChanged="_gridview_PageIndexChanged">
				<Columns>
					<asp:CommandField ShowSelectButton="True"></asp:CommandField>
					<asp:BoundField DataField="Id" HeaderText="Unique ID" SortExpression="Id" />
					<asp:BoundField DataField="Edipi" HeaderText="EDIPI" SortExpression="Edipi" />
					<asp:BoundField DataField="LName" HeaderText="Last Name" SortExpression="LName" />
					<asp:BoundField DataField="FName" HeaderText="First Name" SortExpression="FName" />
					<asp:BoundField DataField="Mi" HeaderText="Mi" SortExpression="Mi" />
					<asp:BoundField DataField="Rank" HeaderText="Rank" SortExpression="Rank" />
					<asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
					<asp:BoundField DataField="AccountType" HeaderText="Account Type" SortExpression="AccountType" />
					<asp:BoundField DataField="AcctStatus" HeaderText="Request Status" SortExpression="AcctStatus" />
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
							<p>Please verify this information is correct and then add your appropriate signature.<p>
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
									<asp:CustomValidator ID="_middleInitialValidator" runat="server" ControlToValidate="_middleInitial" CssClass="label label-warning" ErrorMessage="MI: Please insert only one letter for your middle initial." Text="Requires your attention" OnServerValidate="_middleInitialValidator_ServerValidate" Display="Dynamic"></asp:CustomValidator>
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
									<asp:RegularExpressionValidator ID="_phoneExpressionValidator" CssClass="label label-warning" ControlToValidate="_phone" runat="server" ErrorMessage="Phone: Please enter a valid number." Display="Dynamic" ValidationExpression="\d{3}\.\d{3}\.\d{4}">Requires your attention.</asp:RegularExpressionValidator>
								</div>
							</div>

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

						</div>
					</div>
				</div>
				<%-- End left column --%>

				<%-- Start right column --%>
				<div class="col-sm-6">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3>Signature Box</h3>
							<p>Check the appropriate box to apply your signature (EDIPI). The Supervisor must sign off before the Security Manager.</p>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label for="_supervisorCheckBox" class="col-sm-4 control-label">Supervisor:</label>
								<div class="col-sm-8">
									<div class="input-group">
										<span class="input-group-addon">
											<asp:CheckBox ID="_supervisorCheckBox" runat="server" OnCheckedChanged="_supervisor_CheckBox_CheckedChanged" AutoPostBack="True" />
										</span>
										<asp:TextBox ID="_supervisorSignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("SupEdipi") %>' />
									</div>
									<asp:RequiredFieldValidator ID="_supSignRequiredValidator" runat="server" ErrorMessage="Supervisor signature: You must sign the form before applying your changes." Text="Requires your attention" Display="Dynamic" CssClass="label label-warning" ControlToValidate="_supervisorSignature"></asp:RequiredFieldValidator>
									<asp:CompareValidator ID="_requestorSupervisorCompareValidator" ControlToCompare="_edipi" runat="server" ErrorMessage="Supervisor signature: The Request entry EDIPI and the Supervisor signature can not be the same." CssClass="label label-warning" Display="Dynamic" Text="Requires your attention" ControlToValidate="_supervisorSignature" Operator="NotEqual"></asp:CompareValidator>
								</div>
							</div>

							<asp:PlaceHolder Visible="false" ID="_securityBoxPlaceholder" runat="server">
								<div class="form-group">
									<label for="_securityCheckBox" class="col-sm-4 control-label">Security Manager:</label>
									<div class="col-sm-8">
										<div class="input-group">
											<span class="input-group-addon">
												<asp:CheckBox ID="_securityCheckBox" OnCheckedChanged="_security_CheckBox_CheckedChanged"  runat="server" AutoPostBack="True" />
											</span>
											<asp:TextBox ID="_securitySignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("SecEdipi") %>' />
										</div>
										<asp:CompareValidator ID="_signatureCompareValidator" CssClass="label label-warning" ControlToValidate="_securitySignature" ControlToCompare="_supervisorSignature" runat="server" ErrorMessage="Security Manager signature: The Supervisor and Security Manager can not be the same person." Type="String" Operator="NotEqual" Text="Requires your attention" Display="Dynamic"></asp:CompareValidator>
										<asp:RequiredFieldValidator ID="_secSignRequiredValidator" runat="server" ErrorMessage="Security Manager signature: You must sign the form before applying your changes." Text="Requires your attention" Display="Dynamic" CssClass="label label-warning" ControlToValidate="_securitySignature"></asp:RequiredFieldValidator>
										<asp:CompareValidator ID="_requestorSecurityCompareValidator" ControlToCompare="_edipi" runat="server" ErrorMessage="Security Manager signature: The Request entry EDIPI and the Security Manager signature can not be the same." CssClass="label label-warning" Display="Dynamic" Text="Requires your attention" ControlToValidate="_securitySignature" Operator="NotEqual"></asp:CompareValidator>
									</div>
								</div>
							</asp:PlaceHolder>
						</div>
						<div class="panel-footer">
							<asp:Button ID="_updateButton" data-confirm-modal="By clicking ok, you certify that this user requires access as requested and that the information provided is correct." data-loading-text="Validating information..." CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Update" Text="Verify Request" />
							<asp:Button ID="_cancelButton" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" OnClick="_cancelButton_Click" />
						</div>
					</div> <%-- End Signature block --%>
					<asp:ValidationSummary CssClass="alert alert-danger" ID="_validationSummary" runat="server" />	
				</div>
			</div>
			<div class="hidden">
				<asp:TextBox ID="_supSignedDate" Text='<%# Bind("SupDateSigned") %>' Enabled="false" runat="server"></asp:TextBox>
				<asp:CheckBox ID="_supSigned" Checked='<%# Bind("SupSigned") %>' Enabled="false" runat="server" />
				<asp:TextBox ID="_secSignedDate" Text='<%# Bind("SecDateSigned") %>' Enabled="false" runat="server"></asp:TextBox>
				<asp:CheckBox ID="_secSigned" Checked='<%# Bind("SecSigned") %>' Enabled="false" runat="server" />
				<asp:TextBox ID="_acctStatus" Text='<%# Bind("AcctStatus") %>' Enabled="false" runat="server"></asp:TextBox>
				<asp:TextBox ID="_accountType" Text='<%# Bind("AccountType") %>' Enabled="false" runat="server"></asp:TextBox>
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
</asp:Content>
