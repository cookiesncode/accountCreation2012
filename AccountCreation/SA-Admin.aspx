<%@ Page Title="SA Admin Panel" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="SA-Admin.aspx.cs" Inherits="AccountCreation.SA_Admin" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	
	<h2 class="page-header">SA Admin Panel</h2>
	
	<asp:Panel ID="_filterPanel" Visible="true" runat="server">
		<p class="lead">Filter Records:</p>
		<div class="row">
			<div class="col-sm-6">
				<div class="form-group">
					<label for="_filterRequestType" class="col-sm-5 col-md-4 control-label">Request Type:</label>
					<div class="col-sm-7 col-md-8">
						<asp:DropDownList ID="_filterRequestType" CssClass="form-control" runat="server" AutoPostBack="true">
							<asp:ListItem Text="No filter" Value=""></asp:ListItem>
							<asp:ListItem Text="Automated Creation" Value="Auto"></asp:ListItem>
							<asp:ListItem Text="Manual Creation (SA)" Value="Manual"></asp:ListItem>
						</asp:DropDownList>
					</div>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="form-group">
					<label for="_filterRequestStatus" class="col-sm-5 col-md-4 control-label">Request Status:</label>
					<div class="col-sm-7 col-md-8">
						<asp:DropDownList ID="_filterRequestStatus" CssClass="form-control" runat="server" AutoPostBack="true">
							<asp:ListItem Text="No filter" Value=""></asp:ListItem>
							<asp:ListItem Text="Submitted" Value="Submitted"></asp:ListItem>
							<asp:ListItem Text="Partially Verified" Value="Partially Verified"></asp:ListItem>
							<asp:ListItem Text="Ready to Create" Value="Ready"></asp:ListItem>
							<asp:ListItem Text="Successfully Created" Value="Successful"></asp:ListItem>
							<asp:ListItem Text="Failed to Create" Value="Failed"></asp:ListItem>
						</asp:DropDownList>
					</div>
				</div>
			</div>
		</div>
	</asp:Panel>
	
	<div class="panel panel-default buffer">
		<div class="panel-heading">
			<div class="row">
				<div class="col-sm-6">
					<h3>Request Records</h3>
				</div>
				<div class="col-xs-5 col-sm-offset-2 col-sm-4">
					<div class="input-group sa-search">
						<asp:TextBox CssClass="form-control" placeholder="EDIPI or Last Name or First Name" ID="_searchBox" runat="server" ValidationGroup="_searchValidationGroup"></asp:TextBox>
						<span class="input-group-btn">
							<asp:Button data-loading-text="Searching..." ID="_searchButton" CausesValidation="true" CssClass="btn btn-primary" ValidationGroup="_searchValidationGroup" runat="server" Text="Search" OnClick="_searchButton_Click" />
						</span>
					</div>
				</div>
			</div>
		</div>
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
				Visible="true" 
				EmptyDataText="No results found">
				<Columns>
					<asp:CommandField ShowSelectButton="True"></asp:CommandField>
					<asp:BoundField DataField="Edipi" HeaderText="EDIPI" SortExpression="Edipi" />
					<asp:BoundField DataField="LName" HeaderText="Last Name" SortExpression="LName" />
					<asp:BoundField DataField="FName" HeaderText="First Name" SortExpression="FName" />
					<asp:BoundField DataField="Mi" HeaderText="Mi" SortExpression="Mi" />
					<asp:BoundField DataField="Rank" HeaderText="Rank" SortExpression="Rank" />
					<asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
					<asp:BoundField DataField="RequestType" HeaderText="Request Type" SortExpression="RequestType" />
					<asp:BoundField DataField="SaEdipi" HeaderText="SA EDIPI" SortExpression="SaEdipi" />
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
						</div>
						<div class="panel-body">							
							<div class="form-group">
								<label for="_edipi" class="col-sm-4 control-label">EDIPI:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="Literal1" Text='<%# Eval("Edipi") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>

							<div class="form-group">
								<label for="_lName" class="col-sm-4 control-label">Last Name:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_lName" Text='<%# Eval("LName") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>

							<div class="form-group">
								<label for="_fName" class="col-sm-4 control-label">First Name:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_fName" Text='<%# Eval("FName") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>
				
							<div class="form-group">
								<label for="_middleInitial" class="col-sm-4 control-label">MI:</label>
								<div class="col-sm-3">
									<p class="form-control-static">
										<asp:Literal ID="_middleInitial" Text='<%# Eval("Mi") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>

							<div class="form-group">
								<label for="_email" class="col-sm-4 control-label">AKO Email:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_email" Text='<%# Eval("Email") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>

							<div class="form-group">
								<label for="_rank" class="col-sm-4 control-label">Rank:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_rank" Text='<%# Eval("Rank") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>
	
							<div class="form-group">
								<label for="_branch" class="col-sm-4 control-label">Branch:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_branch" Text='<%# Eval("Branch") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>
		
							<div class="form-group">
								<label for="_org" class="col-sm-4 control-label">Organization:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_org" Text='<%# Eval("Org") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>
					
							<div class="form-group">
								<label for="_department" class="col-sm-4 control-label">Department:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_department" Text='<%# Eval("Department") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>
					
							<div class="form-group">
								<label for="_installation" class="col-sm-4 control-label">Installation:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_installation" Text='<%# Eval("Installation") %>' runat="server"></asp:Literal>
									</p>
				</div>
							</div>
		
							<div class="form-group">
								<label for="_bldgNum" class="col-sm-4 control-label">Bldg. Number:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_bldgNum" Text='<%# Eval("Bldg") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>
				
							<div class="form-group">
								<label for="_roomNum" class="col-sm-4 control-label">Room Number:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_roomNum" Text='<%# Eval("Room") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>
				
							<div class="form-group">
								<label for="_office" class="col-sm-4 control-label">Office:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_office" Text='<%# Eval("Office") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>

							<div class="form-group">
								<label for="_phone" class="col-sm-4 control-label">Phone Number:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_phone" Text='<%# Eval("Phone") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%-- End left column --%>

				<%-- Start right column --%>
				<div class="col-sm-6">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3>SA Signature Box:</h3>
							<p>Once you have created the account, please check the box to apply your signature (EDIPI).</p>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label for="_saCheckBox" class="col-sm-4 control-label">Completed by:</label>
								<div class="col-sm-8">
									<div class="input-group">
										<span class="input-group-addon">
											<asp:CheckBox ID="_saCheckBox" runat="server" OnCheckedChanged="_sa_CheckBox_CheckedChanged" AutoPostBack="True" />
										</span>
										<asp:TextBox ID="_saSignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("SaEdipi") %>' />
									</div>
									<asp:RequiredFieldValidator ID="_saSignRequiredValidator" runat="server" ErrorMessage="SA signature: You must sign the form before completing the request." Text="Requires your attention" Display="Dynamic" CssClass="label label-warning" ControlToValidate="_saSignature"></asp:RequiredFieldValidator>
								</div>
							</div>
						</div>
						<div class="panel-footer">
							<asp:Button ID="_updateButton" CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Update" Text="Complete Request" />
							<asp:Button ID="_cancelButton" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" OnClick="_cancelButton_Click" />
						</div>
					</div> <%-- End Signature block --%>
					<asp:ValidationSummary CssClass="alert alert-danger" ID="_validationSummary" runat="server" />	
				</div>
			</div>
			<div class="hidden">
				<asp:TextBox ID="_acctStatus" Text='<%# Bind("AcctStatus") %>' Enabled="false" runat="server"></asp:TextBox>
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
		<asp:PropertyExpression>
			<asp:ControlParameter ControlID="_filterRequestType" Name="RequestType" />
		</asp:PropertyExpression>
		<asp:PropertyExpression>
			<asp:ControlParameter ControlID="_filterRequestStatus" Name="AcctStatus" />
		</asp:PropertyExpression>
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
