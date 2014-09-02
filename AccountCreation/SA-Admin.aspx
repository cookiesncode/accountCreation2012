<%@ Page Title="SA Admin Panel" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="sa-admin.aspx.cs" Inherits="AccountCreation.SA_Admin" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="_childHead" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>

<asp:Content ID="_childMainContent" ContentPlaceHolderID="_masterMainContent" runat="server">
	
	<h2 class="page-header hidden-print">Admin Panel</h2>
	
	<asp:Panel ID="_filterPanel" CssClass="hidden-print" Visible="true" runat="server">
		<p class="lead">Filter Records:</p>
		<div class="row">
			<div class="col-sm-4">
				<div class="form-group">
					<label for="_filterAccountType" class="col-sm-5 col-md-4 control-label">Account Type:</label>
					<div class="col-sm-7 col-md-8">
						<asp:DropDownList ID="_filterAccountType" OnSelectedIndexChanged="_filter_SelectedIndexChanged" CssClass="form-control" runat="server" AutoPostBack="true">
							<asp:ListItem Text="No filter" Value=""></asp:ListItem>
							<asp:ListItem Text="NIPR" Value="NIPR"></asp:ListItem>
							<asp:ListItem Text="SA" Value="SA"></asp:ListItem>
							<asp:ListItem Text="EP" Value="EP"></asp:ListItem>
							<asp:ListItem Text="VPN" Value="VPN"></asp:ListItem>
							<asp:ListItem Text="SIPR" Value="SIPR"></asp:ListItem>
						</asp:DropDownList>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="form-group">
					<label for="_filterRequestType" class="col-sm-5 col-md-4 control-label">Request Type:</label>
					<div class="col-sm-7 col-md-8">
						<asp:DropDownList ID="_filterRequestType" OnSelectedIndexChanged="_filter_SelectedIndexChanged" CssClass="form-control" runat="server" AutoPostBack="true">
							<asp:ListItem Text="No filter" Value=""></asp:ListItem>
							<asp:ListItem Text="Automated Request" Value="Auto Create"></asp:ListItem>
							<asp:ListItem Text="Manual Request (SA)" Value="Manual"></asp:ListItem>
						</asp:DropDownList>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="form-group">
					<label for="_filterRequestStatus" class="col-sm-5 col-md-4 control-label">Request Status:</label>
					<div class="col-sm-7 col-md-8">
						<asp:DropDownList ID="_filterRequestStatus" OnSelectedIndexChanged="_filter_SelectedIndexChanged" CssClass="form-control" runat="server" AutoPostBack="true">
							<asp:ListItem Text="No filter" Value=""></asp:ListItem>
							<asp:ListItem Text="Requested" Value="Requested"></asp:ListItem>
							<asp:ListItem Text="Partially Verified" Value="Partially Verified"></asp:ListItem>
							<asp:ListItem Text="Ready" Value="Ready"></asp:ListItem>
							<asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
							<asp:ListItem Text="IA Approved" Value="IA Approved"></asp:ListItem>
							<asp:ListItem Text="DSD Approved" Value="DSD Approved"></asp:ListItem>
							<asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
							<asp:ListItem Text="Denied" Value="Denied"></asp:ListItem>
							<asp:ListItem Text="Failed" Value="Failed"></asp:ListItem>
						</asp:DropDownList>
					</div>
				</div>
			</div>
		</div>
	</asp:Panel>
	
	<div class="panel panel-default buffer hidden-print">
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
                AutoGenerateColumns="False"
                AllowSorting="True"
                OnSelectedIndexChanged="_gridview_SelectedIndexChanged"
                OnPageIndexChanged="_gridview_PageIndexChanged"
                EmptyDataText="No results found"
                EnablePersistedSelection="True" 
                AllowPaging="True" 
                PageSize="25"
                PagerStyle-CssClass="table-pagination">
				<Columns>
                    <%-- TODO: Change it back to bound fields since templates arent required anymore --%>
                    <asp:CommandField ShowSelectButton="True"></asp:CommandField>
                    <asp:TemplateField HeaderText="Requested Date" SortExpression="RequestedDate">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("RequestedDate", "{0:d}") %>' ID="_requestedDate"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="EDIPI" SortExpression="Edipi">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Edipi") %>' ID="_edipi"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Name" SortExpression="LName">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("LName") %>' ID="_lastName"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="First Name" SortExpression="FName">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("FName") %>' ID="_firstName"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Mi" SortExpression="Mi">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Mi") %>' ID="_middleInitial"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rank" SortExpression="Rank">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Rank") %>' ID="_rank"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Account Type" SortExpression="AccountType">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("AccountType") %>' ID="_accountType"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Request Type" SortExpression="RequestType">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("RequestType") %>' ID="_requestType"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Request Status" SortExpression="RequestStatus">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("RequestStatus") %>' ID="_requestStatus"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SA Employee" SortExpression="SaName">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("SaName") %>' ID="_saName"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
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
						<div class="panel-heading hidden-print clearfix">
							<h3 class="pull-left">Request Entry</h3>
                            <button id="print-btn" class="btn btn-primary pull-right print-btn"><i class="glyphicon glyphicon-print"></i></button>
						</div>
						<div class="panel-body">							
							<div class="form-group">
								<label for="_edipi" class="col-sm-4 control-label">EDIPI:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_edipi" Text='<%# Eval("Edipi") %>' runat="server"></asp:Literal>
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
								<label for="_email" class="col-sm-4 control-label">Enterprise Email:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_email" Text='<%# Eval("Email") %>' runat="server"></asp:Literal>
									</p>
								</div>
							</div>
		
							<div class="form-group">
								<label for="_persona" class="col-sm-4 control-label">Persona:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_persona" Text='<%# Eval("Persona") %>' runat="server"></asp:Literal>
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
								<label for="_macom" class="col-sm-4 control-label">MACOM:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_macom" Text='<%# Eval("Macom") %>' runat="server"></asp:Literal>
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
								<label for="_orgUnit" class="col-sm-4 control-label">Org/Unit:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_orgUnit" Text='<%# Eval("OrgUnit") %>' runat="server"></asp:Literal>
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
								<label for="_bldgNum" class="col-sm-4 control-label">Bldg Number:</label>
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

                            <asp:Panel ID="_deleteRequestPanel" runat="server">
								<div class="form-group">
									<label for="_deleteDate" class="col-sm-4 control-label">Requested Delete Date:</label>
									<div class="col-sm-8">
                                        <p class="form-control-static">
										    <asp:Literal ID="_deleteDate" Text='<%# Eval("DeleteDate") %>' runat="server"></asp:Literal>
									    </p>									
									</div>
								</div>
                            </asp:Panel>

                            <asp:Panel ID="_justificationPanel" runat="server">
                                <div class="form-group">
								    <label for="_justification" class="col-sm-4 control-label">Justification:</label>
								    <div class="col-sm-8">
                                        <p class="form-control-static">
									        <asp:Literal ID="_justification" runat="server" Text='<%# Eval("Justification") %>' />
                                        </p>
								    </div>
							    </div>
                            </asp:Panel>
							
							<asp:Panel ID="_saPanel" CssClass="hidden-print" runat="server">
                                <h4 class="page-header">SA Request Information</h4>
								<div class="form-group">
									<label for="_mos" class="col-sm-4 control-label">MOS / Job Title:</label>
									<div class="col-sm-8">
										<p class="form-control-static">
											<asp:Literal ID="_mos" Text='<%# Eval("Mos") %>' runat="server"></asp:Literal>
										</p>
									</div>
								</div>
								<div class="form-group">
									<label for="_selectedUnits" class="col-sm-4 control-label">Requested Units:</label>
									<div class="col-sm-8">
										<p class="form-control-static">
											<asp:Literal ID="_selectedUnits" Text='<%# Eval("EpUnits") %>' runat="server"></asp:Literal>
										</p>
									</div>
								</div>
                                <div class="form-group">
								<label for="_supervisorName" class="col-sm-4 control-label">Supervisor's Name:</label>
								<div class="col-sm-8">
									<p class="form-control-static">
										<asp:Literal ID="_supervisorName" runat="server"></asp:Literal>
									</p>
								</div>
							</div>
							</asp:Panel>
						</div>
					</div>
				</div>
				<%-- End left column --%>

				<%-- Start right column --%>
				<div class="col-sm-6 hidden-print">
                    <asp:PlaceHolder ID="_iaSection" runat="server">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3>IA Section</h3>
                            </div>
                            <div class="panel-body">	
                                <div class="form-group">
                                    <label for="_iaRemark" class="col-sm-4 control-label">Remark:</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" ID="_iaRemark" TextMode="MultiLine" Rows="6" CssClass="form-control" Text='<%# Bind("IaRemark") %>'></asp:TextBox>
                                    </div>
                                </div>							    
								<div class="form-group">
									<label for="_iaApproval" class="col-sm-4 control-label">Request Approval:</label>
									<div class="col-sm-8">
                                        <asp:RadioButtonList ID="_iaApproval" OnSelectedIndexChanged="_iaApproval_SelectedIndexChanged" AutoPostBack="true" CssClass="radio requestRadio" RepeatLayout="Flow" runat="server">
                                            <asp:ListItem Value="Approved">Approved</asp:ListItem>
                                            <asp:ListItem Value="Denied">Denied</asp:ListItem>
                                        </asp:RadioButtonList>
										<asp:RequiredFieldValidator CssClass="label label-warning" ID="_iaApprovalRequiredValidator" runat="server" ErrorMessage="Request Approval: Please make a selection." ValidationGroup="iaValGroup" ControlToValidate="_iaApproval" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									</div>
								</div>
                                <div class="form-group">
								    <label for="_iaCheckBox" class="col-sm-4 control-label">IA Signature:</label>
								    <div class="col-sm-8">
									    <div class="input-group">
										    <span class="input-group-addon">
											    <asp:CheckBox ID="_iaCheckBox" Checked='<%# Bind("IaSigned") %>' OnCheckedChanged="_iA_CheckBox_CheckedChanged" runat="server" AutoPostBack="True" />
										    </span>
										    <asp:TextBox ID="_iaSignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("IaEdipi") %>' />
									    </div>
                                        <small class="help-block">Check the box to apply your signature.</small>
									    <asp:RequiredFieldValidator ID="_iASignRequiredValidator" ValidationGroup="iaValGroup" runat="server" ErrorMessage="IA signature: You must sign the form before applying your changes." Text="Requires your attention" Display="Dynamic" CssClass="label label-warning" ControlToValidate="_iaSignature"></asp:RequiredFieldValidator>
									    <asp:CompareValidator ID="_iaUserCompareValidator" ValidationGroup="iaValGroup" ControlToValidate="_iaSignature" ControlToCompare="_userEdipi" runat="server" ErrorMessage="IA signature: The Request entry EDIPI and the IA signature can not be the same." CssClass="label label-warning" Display="Dynamic" Text="Requires your attention" Operator="NotEqual"></asp:CompareValidator>
								    </div>
							    </div>					
						    </div>
						    <div class="panel-footer">
							    <asp:Button ID="_iaSubmit" OnClick="_iaSubmit_Click" ValidationGroup="iaValGroup" data-loading-text="Validating information..." CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Update" Text="Update Request" />
							    <asp:Button ID="_iaCancelBtn" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" OnClick="_cancelButton_Click" />
						    </div>
                        </div>
                    </asp:PlaceHolder>

					<asp:ValidationSummary ValidationGroup="iaValGroup" CssClass="alert alert-danger" ID="_iaValidationSummary" runat="server" />	

                    <asp:PlaceHolder ID="_dsdSection" runat="server">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3>DSD Section</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="_dsdRemark" class="col-sm-4 control-label">Remark:</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" ID="_dsdRemark" TextMode="MultiLine" Rows="6" CssClass="form-control" Text='<%# Bind("DsdRemark") %>'></asp:TextBox>
                                    </div>
                                </div>
								<div class="form-group">
									<label for="_dsdApproval" class="col-sm-4 control-label">Request Approval:</label>
									<div class="col-sm-8">
                                        <asp:RadioButtonList ID="_dsdApproval" OnSelectedIndexChanged="_dsdApproval_SelectedIndexChanged" AutoPostBack="true" CssClass="radio requestRadio" RepeatLayout="Flow" runat="server">
                                            <asp:ListItem Value="Approved">Approved</asp:ListItem>
                                            <asp:ListItem Value="Denied">Denied</asp:ListItem>
                                        </asp:RadioButtonList>
										<asp:RequiredFieldValidator ValidationGroup="dsdValGroup" CssClass="label label-warning" ID="_dsdApprovalRequiredValidator" runat="server" ErrorMessage="Request Approval: Please make a selection." ControlToValidate="_dsdApproval" Text="Requires your attention" Display="Dynamic"></asp:RequiredFieldValidator>
									</div>
								</div>
							    <div class="form-group">
								    <label for="_dsdCheckBox" class="col-sm-4 control-label">DSD Signature:</label>
								    <div class="col-sm-8">
									    <div class="input-group">
										    <span class="input-group-addon">
											    <asp:CheckBox ID="_dsdCheckBox" Checked='<%# Bind("DsdSigned") %>' OnCheckedChanged="_dsd_CheckBox_CheckedChanged" runat="server" AutoPostBack="True" />
										    </span>
										    <asp:TextBox ID="_dsdSignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("DsdEdipi") %>' />
									    </div>
                                        <small class="help-block">Check the box to apply your signature.</small>
									    <asp:RequiredFieldValidator ID="_dsdRequiredValidator" ValidationGroup="dsdValGroup" runat="server" ErrorMessage="DSD signature: You must sign the form before applying your changes." Text="Requires your attention" Display="Dynamic" CssClass="label label-warning" ControlToValidate="_dsdSignature"></asp:RequiredFieldValidator>
									    <asp:CompareValidator ID="_dsdUserCompareValidator" ValidationGroup="dsdValGroup" ControlToValidate="_dsdSignature" ControlToCompare="_userEdipi" runat="server" ErrorMessage="DSD signature: The Request entry EDIPI and the DSD signature can not be the same." CssClass="label label-warning" Display="Dynamic" Text="Requires your attention" Operator="NotEqual"></asp:CompareValidator>
									    <asp:CompareValidator ID="_iaDsdCompareValidator" ValidationGroup="dsdValGroup" CssClass="label label-warning" ControlToValidate="_dsdSignature" ControlToCompare="_iaSignature" runat="server" ErrorMessage="DSD signature: The IA signature and the DSD signature can not be the same." Type="String" Operator="NotEqual" Text="Requires your attention" Display="Dynamic"></asp:CompareValidator>
								    </div>
							    </div>					
						    </div>
						    <div class="panel-footer">
							    <asp:Button ID="_dsdSubmit" OnClick="_dsdSubmit_Click" ValidationGroup="dsdValGroup" data-loading-text="Validating information..." CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Update" Text="Update Request" />
							    <asp:Button ID="_dsdCancelBtn" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" OnClick="_cancelButton_Click" />
						    </div>
                        </div>
                    </asp:PlaceHolder>

					<asp:ValidationSummary ValidationGroup="dsdValGroup" CssClass="alert alert-danger" ID="_dsdValidationSummary" runat="server" />	
					
                    <asp:PlaceHolder ID="_saSection" runat="server">
                        <div class="panel panel-default">
						    <div class="panel-heading">
							    <h3>SA Section</h3>
							    <p>Please fill out the information below and then apply your signature (EDIPI).</p>
						    </div>
						    <div class="panel-body">
							    <asp:PlaceHolder ID="_adInfo" Visible="false" runat="server">
								    <div class="form-group">
									    <label for="_samAccount" class="col-sm-4 control-label">SAM Account:</label>
									    <div class="col-sm-8">
										    <asp:TextBox ID="_samAccount" CssClass="form-control" Text='<%# Bind("SamAccountName") %>' runat="server"></asp:TextBox>
									    </div>
								    </div>

								    <div class="form-group">
									    <label for="_homeFolder" class="col-sm-4 control-label">Home Folder:</label>
									    <div class="col-sm-8">
										    <asp:TextBox ID="_homeFolder" CssClass="form-control" Text='<%# Bind("HomeFolder") %>' runat="server"></asp:TextBox>
									    </div>
								    </div>
							    </asp:PlaceHolder>
                                <div class="form-group">
                                    <label for="_saRemark" class="col-sm-4 control-label">Remark:</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" ID="_saRemark" TextMode="MultiLine" Rows="6" CssClass="form-control" Text='<%# Bind("SaRemark") %>'></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="_editRequestStatus" class="col-sm-4 control-label">Request Status:</label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList runat="server" ID="_editRequestStatus" SelectedValue='<%# Bind("RequestStatus") %>' CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="_editRequestStatus_SelectedIndexChanged">
							                <asp:ListItem Text="Requested" Value="Requested"></asp:ListItem>
							                <asp:ListItem Text="Partially Verified" Value="Partially Verified"></asp:ListItem>
							                <asp:ListItem Text="Ready" Value="Ready"></asp:ListItem>
							                <asp:ListItem Text="IA Approved" Value="IA Approved"></asp:ListItem>
							                <asp:ListItem Text="DSD Approved" Value="DSD Approved"></asp:ListItem>
							                <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
							                <asp:ListItem Text="Denied" Value="Denied"></asp:ListItem>
							                <asp:ListItem Text="Failed" Value="Failed"></asp:ListItem>
							                <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
							    <div class="form-group">
								    <label for="_saCheckBox" class="col-sm-4 control-label">SA Signature:</label>
								    <div class="col-sm-8">
									    <div class="input-group">
										    <span class="input-group-addon">
											    <asp:CheckBox ID="_saCheckBox" runat="server" Checked='<%# Bind("SaSigned") %>' OnCheckedChanged="_sa_CheckBox_CheckedChanged" AutoPostBack="True" />
										    </span>
										    <asp:TextBox ID="_saSignature" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("SaEdipi") %>' />
									    </div>
									    <asp:RequiredFieldValidator ID="_saSignRequiredValidator"  ValidationGroup="saValGroup" runat="server" ErrorMessage="SA signature: You must sign the form before completing the request." Text="Requires your attention" Display="Dynamic" CssClass="label label-warning" ControlToValidate="_saSignature"></asp:RequiredFieldValidator>
									    <asp:CompareValidator ID="_saUserCompareValidator"  ValidationGroup="saValGroup" ControlToValidate="_saSignature" ControlToCompare="_userEdipi" runat="server" ErrorMessage="SA signature: The Request entry EDIPI and the SA signature can not be the same." CssClass="label label-warning" Display="Dynamic" Text="Requires your attention" Operator="NotEqual"></asp:CompareValidator>
									    <asp:CompareValidator ID="_saDsdCompareValidator"  ValidationGroup="saValGroup" ControlToValidate="_saSignature" ControlToCompare="_dsdSignature" runat="server" ErrorMessage="SA signature: The SA signature and the DSD signature can not be the same." CssClass="label label-warning" Display="Dynamic" Text="Requires your attention" Operator="NotEqual"></asp:CompareValidator>
									    <asp:CompareValidator ID="_saIaCompareValidator"  ValidationGroup="saValGroup" ControlToValidate="_saSignature" ControlToCompare="_iaSignature" runat="server" ErrorMessage="SA signature: The SA signature and the IA signature can not be the same." CssClass="label label-warning" Display="Dynamic" Text="Requires your attention" Operator="NotEqual"></asp:CompareValidator>
								    </div>
							    </div>
						    </div>
						    <div class="panel-footer">
							    <asp:Button ID="_saSubmit" OnClick="_saSubmit_Click" ValidationGroup="saValGroup" data-loading-text="Validating information..." CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Update" Text="Update Request" />
							    <asp:Button ID="_saCancelBtn" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" OnClick="_cancelButton_Click" />
						    </div>
                        </div>
                    </asp:PlaceHolder>

					<asp:ValidationSummary ValidationGroup="saValGroup" CssClass="alert alert-danger" ID="_saValidationSummary" runat="server" />	
				</div>
                <%-- End right column --%>
			</div>
			<div class="hidden">
                <asp:TextBox ID="_userEdipi" Text='<%# Eval("Edipi") %>' runat="server"></asp:TextBox>
				<asp:TextBox ID="_supervisorEdipi" Text='<%# Eval("SupEdipi") %>' runat="server"></asp:TextBox>
				<asp:TextBox ID="_saName" Text='<%# Bind("SaName") %>' runat="server"></asp:TextBox>
				<asp:TextBox ID="_completedDate" Text='<%# Bind("CompletedDate") %>' runat="server"></asp:TextBox>
				<asp:TextBox ID="_iaDateSigned" Text='<%# Bind("IaDateSigned") %>' runat="server"></asp:TextBox>
				<asp:TextBox ID="_dsdDateSigned" Text='<%# Bind("DsdDateSigned") %>' runat="server"></asp:TextBox>
				<asp:TextBox ID="_saDateSigned" Text='<%# Bind("SaDateSigned") %>' runat="server"></asp:TextBox>
				<asp:TextBox ID="_modifiedDate" Text='<%# Bind("ModifiedDate") %>' runat="server"></asp:TextBox>
				<asp:TextBox ID="_accountType" Text='<%# Eval("AccountType") %>' runat="server"></asp:TextBox>
				<asp:TextBox ID="_requestType" Text='<%# Eval("RequestType") %>' runat="server"></asp:TextBox>
				<asp:TextBox ID="_requestStatus" Text='<%# Bind("RequestStatus") %>' runat="server"></asp:TextBox>
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
		<asp:SearchExpression DataFields="RequestStatus" SearchType="Contains">
            <asp:ControlParameter ControlID="_filterRequestStatus" />
		</asp:SearchExpression>
		<asp:SearchExpression DataFields="RequestType" SearchType="Contains">
            <asp:ControlParameter ControlID="_filterRequestType" />
		</asp:SearchExpression>
		<asp:SearchExpression DataFields="AccountType" SearchType="Contains">
            <asp:ControlParameter ControlID="_filterAccountType" />
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
