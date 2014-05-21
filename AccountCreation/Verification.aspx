<%@ Page Title="Request Verification" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Verification.aspx.cs" Inherits="AccountCreation.Verification" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	
	<h2 class="page-header">Request Verification</h2>
	
	<asp:Panel ID="_searchPanel" CssClass="search-panel buffer" DefaultButton="_searchButton" runat="server">
		<p class="lead">Please search by the <abbr class="initialism" title="Electronic Data Interchange Personal Identifier">EDIPI</abbr> number, last name, or first name.</p>
		<p><strong class="text-info">Note:</strong> Searching by <abbr class="initialism" title="Electronic Data Interchange Personal Identifier">EDIPI</abbr> gives you more accurate results.</p>
		
		<div class="form-group">
			<div class="col-xs-6 col-sm-5 col-md-4 col-lg-3">
				<div class="input-group">
					<asp:TextBox CssClass="form-control" ID="_searchBox" runat="server"></asp:TextBox>
					<span class="input-group-btn">
						<asp:Button ID="_searchButton" data-loading-text="Searching..." CausesValidation="false" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="_searchButton_Click" />
					</span>
				</div>
			</div>
		</div>
	</asp:Panel>
	
	<div class="panel panel-default buffer">
		<div class="panel-heading">Search Results</div>
		<div class="table-responsive">
			<asp:GridView ID="_gridview" runat="server" 
				CssClass="table table-condensed table-hover"
				DataKeyNames="Id" 
				DataSourceID="_gridEntitySource" 
				GridLines="None"
				AllowPaging="True" 
				AutoGenerateColumns="False" 
				AllowSorting="True" 
				OnSelectedIndexChanged="_gridview_SelectedIndexChanged"
				Visible="false" 
				EmptyDataText="No results found">
				<Columns>
					<asp:CommandField ShowSelectButton="True"></asp:CommandField>
					<asp:BoundField DataField="Edipi" HeaderText="EDIPI" SortExpression="Edipi" />
					<asp:BoundField DataField="LName" HeaderText="Last Name" SortExpression="LName" />
					<asp:BoundField DataField="FName" HeaderText="First Name" SortExpression="FName" />
					<asp:BoundField DataField="Mi" HeaderText="Mi" SortExpression="Mi" />
					<asp:BoundField DataField="Rank" HeaderText="Rank" SortExpression="Rank" />
					<asp:BoundField DataField="SupEdipi" HeaderText="Supervisor EDIPI" SortExpression="SupEdipi" />
					<asp:BoundField DataField="SecEdipi" HeaderText="Security EDIPI" SortExpression="SecEdipi" />
				</Columns>
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
			<div class="form-group">
				<label for="_edipi" class="col-sm-2 control-label">EDIPI:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_edipi"  Enabled="false" CssClass="form-control" runat="server" Text='<%# Eval("Edipi") %>'  />
					<asp:RequiredFieldValidator CssClass="label label-warning" ID="_edipiRequiredValidator" runat="server" ErrorMessage="EDIPI: Please enter your EDIPI number." ControlToValidate="_edipi" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>

				</div>
			</div>

			<div class="form-group">
				<label for="_lName" class="col-sm-2 control-label">Last Name:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_lName" CssClass="form-control" Enabled="false" runat="server" Text='<%# Eval("LName") %>' />
					<asp:RequiredFieldValidator CssClass="label label-warning" ID="_lNameRequiredValidator" runat="server" ErrorMessage="Last name: Please enter your last name." ControlToValidate="_lName" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>

				</div>
			</div>

			<div class="form-group">
				<label for="_fName" class="col-sm-2 control-label">First Name:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_fName" CssClass="form-control" Enabled="false" runat="server" Text='<%# Eval("FName") %>' />
					<asp:RequiredFieldValidator CssClass="label label-warning" ID="_fNameRequiredValidator" runat="server" ErrorMessage="First name: Please enter your first name." ControlToValidate="_fName" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
				</div>
			</div>
				
			<div class="form-group">
				<label for="_middleInitial" class="col-sm-2 control-label">MI:</label>
				<div class="col-sm-1">
					<asp:TextBox ID="_middleInitial" CssClass="form-control" runat="server" Text='<%# Bind("Mi") %>' />
					<asp:CustomValidator ID="_middleInitialValidator" runat="server" ControlToValidate="_middleInitial" CssClass="label label-warning" ErrorMessage="MI: Please insert only one letter for your middle initial." Text="Requires your attention" OnServerValidate="_middleInitialValidator_ServerValidate"></asp:CustomValidator>
				</div>
			</div>

			<div class="form-group">
				<label for="_email" class="col-sm-2 control-label">AKO Email:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_email" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' />
					<asp:RequiredFieldValidator CssClass="label label-warning" ID="_emailRequiredValidator" runat="server" ErrorMessage="AKO Email: Please enter your AKO email address." ControlToValidate="_email" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
					<asp:RegularExpressionValidator ID="_emailExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="AKO Email: Please enter a valid email address." Display="Dynamic" ControlToValidate="_email" Text="Requires your attention." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
				</div>
			</div>

			<div class="form-group">
				<label for="_rank" class="col-sm-2 control-label">Rank:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_Rank" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Rank") %>' DataSourceID="_formviewEntitySource" DataTextField="Rank" DataValueField="Rank">
						<asp:ListItem Text="-- Select Rank --" Value="" />
					</asp:DropDownList>
					<asp:RequiredFieldValidator CssClass="label label-warning" ID="_rankRequiredValidator" runat="server" ErrorMessage="Rank: Please select your rank." ControlToValidate="_rank" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
				</div>
			</div>
	
			<div class="form-group">
				<label for="_branch" class="col-sm-2 control-label">Branch:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_branch" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Branch") %>' DataSourceID="_formviewEntitySource" DataTextField="Branch" DataValueField="Branch">
						<asp:ListItem Text="-- Select Branch --" Value="" />
					</asp:DropDownList>
					<asp:RequiredFieldValidator CssClass="label label-warning" ID="_branchRequiredValidator" runat="server" ErrorMessage="Branch: Please select your branch." ControlToValidate="_branch" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
				</div>
			</div>
		
			<div class="form-group">
				<label for="_org" class="col-sm-2 control-label">Organization:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_org" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Org") %>' DataSourceID="_formviewEntitySource" DataTextField="Org" DataValueField="Org">
						<asp:ListItem Text="-- Select Organization --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
					
			<div class="form-group">
				<label for="_department" class="col-sm-2 control-label">Department:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_department" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Department") %>' DataSourceID="_formviewEntitySource" DataTextField="Department" DataValueField="Department">
						<asp:ListItem Text="-- Select Department --" Value="" />
					</asp:DropDownList>
					<asp:RequiredFieldValidator CssClass="label label-warning" ID="_deptRequiredValidator" runat="server" ErrorMessage="Department: Please select your department." ControlToValidate="_department" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
				</div>
			</div>
					
			<div class="form-group">
				<label for="_installation" class="col-sm-2 control-label">Installation:</label>
				<div class="col-sm-3">
					<asp:DropDownList ID="_installation" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Installation") %>' DataSourceID="_formviewEntitySource" DataTextField="Installation" DataValueField="Installation">
						<asp:ListItem Text="-- Select Installation --" Value="" />
					</asp:DropDownList>
				</div>
			</div>
		
			<div class="form-group">
				<label for="_bldgNum" class="col-sm-2 control-label">Bldg. Number:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_bldgNum" CssClass="form-control" runat="server" Text='<%# Bind("Bldg") %>' />
					<asp:RegularExpressionValidator ID="_bldgExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="Bldg: Please enter numbers only." Text="Requires your attention." ControlToValidate="_bldgNum" Display="Dynamic" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
				</div>
			</div>
				
			<div class="form-group">
				<label for="_roomNum" class="col-sm-2 control-label">Room Number:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_roomNum" CssClass="form-control" runat="server" Text='<%# Bind("Room") %>' />
					<asp:RegularExpressionValidator ID="_roomExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="Room number: Please enter numbers only." Text="Requires your attention." ControlToValidate="_roomNum" Display="Dynamic" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
				</div>
			</div>
				
			<div class="form-group">
				<label for="_office" class="col-sm-2 control-label">Office Number:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_office" CssClass="form-control" runat="server" Text='<%# Bind("Office") %>' />
					<asp:RegularExpressionValidator ID="_officeExpressionValidator" CssClass="label label-warning" runat="server" ErrorMessage="Office number: Please enter numbers only." Text="Requires your attention." ControlToValidate="_office" Display="Dynamic" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
				</div>
			</div>

			<div class="form-group">
				<label for="_phone" class="col-sm-2 control-label">Phone Number:</label>
				<div class="col-sm-3">
					<asp:TextBox ID="_phone" CssClass="form-control" placeholder="000-000-0000" runat="server" Text='<%# Bind("Phone") %>' />
					<asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="label label-warning" ControlToValidate="_phone" runat="server" ErrorMessage="Phone: Please enter a valid number." Display="Dynamic" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}">Requires your attention.</asp:RegularExpressionValidator>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-9">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3>Signature box</h3>
							<p>Check the appropriate box. This will populate your EDIPI number as your signature.</p>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label for="_supervisorCheckBox" class="col-sm-2 col-md-3 control-label">Supervisor:</label>
								<div class="col-sm-6 col-md-5">
									<div class="input-group">
										<span class="input-group-addon">
											<asp:CheckBox ID="_supervisorCheckBox" runat="server" OnCheckedChanged="_CheckBox_CheckedChanged" AutoPostBack="True" />
										</span>
										<asp:TextBox ID="_supervisorSignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("SupEdipi") %>' />
									</div>
								</div>
							</div>

							<div class="form-group">
								<label for="_securityCheckBox" class="col-sm-2 col-md-3 control-label">Security Manager:</label>
								<div class="col-sm-6 col-md-5">
									<div class="input-group">
										<span class="input-group-addon">
											<asp:CheckBox ID="_securityCheckBox" OnCheckedChanged="_CheckBox_CheckedChanged"  runat="server" AutoPostBack="True" />
										</span>
										<asp:TextBox ID="_securitySignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("SecEdipi") %>' />
									</div>
									<asp:CompareValidator ID="_signatureCompareValidator" CssClass="label label-warning" ControlToValidate="_securitySignature" ControlToCompare="_supervisorSignature" runat="server" ErrorMessage="Signatures cannot be the same." Type="String" Operator="NotEqual" Text="Requires your attention" Display="Dynamic"></asp:CompareValidator>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<asp:Button ID="_updateButton" CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Update" Text="Update Form" />
					<asp:Button ID="_updateCancelButton" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" OnClick="_updateCancelButton_Click" />
				</div>
			</div>
		</EditItemTemplate>
		<EmptyDataTemplate>
			<p>No records have been found.</p>
		</EmptyDataTemplate>
	</asp:FormView>

	<asp:ValidationSummary CssClass="alert alert-danger" ID="_validationSummary" runat="server" />	

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
