using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.DirectoryServices.ActiveDirectory;


namespace AccountCreation
{
	public partial class SA_Admin : System.Web.UI.Page
	{
        private bool IsSaCreateRequest
        {
            get
            {
                var accountTypeCtrl = (TextBox)(_formview).FindControl("_accountType");
                var requestTypeCtrl = (TextBox)(_formview).FindControl("_requestType");
                if (requestTypeCtrl.Text.Contains("Create") && accountTypeCtrl.Text == "SA")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        private bool IsEpCreateRequest
        {
            get
            {
                var accountTypeCtrl = (TextBox)(_formview).FindControl("_accountType");
                var requestTypeCtrl = (TextBox)(_formview).FindControl("_requestType");
                if (requestTypeCtrl.Text.Contains("Create") && accountTypeCtrl.Text == "EP")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
		{
            if (Page.User.IsInRole("CARSON NEC SSD SMB SA SG") || Page.User.IsInRole("CARSON NEC IA Account Review") || Page.User.IsInRole("CARSON NEC DSD Account Review"))
            {
                var seachQueryString = Request.QueryString["search"];
                if (!IsPostBack && seachQueryString != null)
                {
                    _gridview.Visible = true;
                    _searchBox.Text = seachQueryString;
                }
            }
            else
            {
                Response.StatusCode = 403;
                Response.SuppressContent = true;
            }
		}

		protected void _formview_DataBound(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Edit)
			{
                var accountTypeCtrl = (TextBox)(_formview).FindControl("_accountType");
                var requestTypeCtrl = (TextBox)(_formview).FindControl("_requestType");

                var deleteRequestDateSection = (Panel)(_formview).FindControl("_deleteRequestPanel");

                if (requestTypeCtrl.Text.Contains("Delete"))
                {
                    deleteRequestDateSection.Visible = true;
                }
                else
                {
                    deleteRequestDateSection.Visible = false;
                }

                var siprSection = (Panel)(_formview).FindControl("_siprSection");

                if (accountTypeCtrl.Text == "SIPR" && requestTypeCtrl.Text.Contains("Create"))
                {
                    siprSection.Visible = true;
                }
                else
                {
                    siprSection.Visible = false;
                }


                if (accountTypeCtrl.Text != "NIPR")
				{
                    var saAdInfoSection = (PlaceHolder)(_formview).FindControl("_adInfo");
                    saAdInfoSection.Visible = true;
				}

                if (IsSaCreateRequest || IsEpCreateRequest)
                {
                    // Set visibility defaults for the NEC sections.
                    var iaApprovalSection = (PlaceHolder)(_formview).FindControl("_iaSection");
                    iaApprovalSection.Visible = true;

                    var dsdApprovalSection = (PlaceHolder)(_formview).FindControl("_dsdSection");
                    dsdApprovalSection.Visible = false;

                    var saApprovalSection = (PlaceHolder)(_formview).FindControl("_saSection");
                    saApprovalSection.Visible = false;

                    var requestStatusCtrl = (TextBox)(_formview).FindControl("_requestStatus");
                    var dsdCheckBoxCtrl = (CheckBox)(_formview).FindControl("_dsdCheckBox");
                    var iaCheckBoxCtrl = (CheckBox)(_formview).FindControl("_iaCheckBox");

                    if (IsSaCreateRequest)
                    {
                        var supervisorNameCtrl = (Literal)(_formview).FindControl("_supervisorName");
                        var supervisorEdipiCtrl = (TextBox)(_formview).FindControl("_supervisorEdipi");
                        var supervisorInfo = AdAccount.ReturnActiveDirectoryDisplayName(supervisorEdipiCtrl.Text);
                        supervisorNameCtrl.Text = supervisorInfo;

                        var securityNameCtrl = (Literal)(_formview).FindControl("_securityName");
                        var securityEdipiCtrl = (TextBox)(_formview).FindControl("_securityEdipi");
                        var securityInfo = AdAccount.ReturnActiveDirectoryDisplayName(securityEdipiCtrl.Text);
                        securityNameCtrl.Text = securityInfo;

                        // Update visible properties of each section depending on the value of the request status.
                        if ((requestStatusCtrl.Text == "IA Approved" || requestStatusCtrl.Text == "Completed") && iaCheckBoxCtrl.Checked)
                        {
                            dsdApprovalSection.Visible = true;
                            var imoGroupListCtrl = (ListBox)(_formview).FindControl("_imoGroupList");
                            var imoGroupList = AdAccount.ListImoGroups();
                            foreach (string group in imoGroupList)
                            {
                                imoGroupListCtrl.Items.Add(new ListItem(group, group));
                            }
                        }

                        if ((requestStatusCtrl.Text == "DSD Approved" || requestStatusCtrl.Text == "Completed") && dsdCheckBoxCtrl.Checked)
                        {
                            saApprovalSection.Visible = true;
                        }
                    }
                    else
                    {
                        var saRequestInfoSection = (Panel)(_formview).FindControl("_saPanel");
                        saRequestInfoSection.Visible = false;

                        if ((requestStatusCtrl.Text == "IA Approved" || requestStatusCtrl.Text == "Completed") && iaCheckBoxCtrl.Checked)
                        {
                            saApprovalSection.Visible = true;
                        }
                    }
                    
                    // Set defaults for the individual controls inside the NEC approval sections
                    var dsdSubmitBtn = (Button)(_formview).FindControl("_dsdSubmit");
                    dsdSubmitBtn.Visible = false;
                    var dsdRemarkCtrl = (TextBox)(_formview).FindControl("_dsdRemark");
                    dsdRemarkCtrl.Enabled = false;
                    var dsdCheckboxCtrl = (CheckBox)(_formview).FindControl("_dsdCheckBox");
                    dsdCheckboxCtrl.Enabled = false;
                    var dsdApprovalCtrl = (RadioButtonList)(_formview).FindControl("_dsdApproval");
                    dsdApprovalCtrl.Enabled = false;
                    var dsdImoList = (ListBox)(_formview).FindControl("_imoGroupList");
                    dsdImoList.Enabled = false;

                    var iaSubmitBtn = (Button)(_formview).FindControl("_iaSubmit");
                    iaSubmitBtn.Visible = false;
                    var iaRemarkCtrl = (TextBox)(_formview).FindControl("_iaRemark");
                    iaRemarkCtrl.Enabled = false;
                    var iaCheckboxCtrl = (CheckBox)(_formview).FindControl("_iaCheckBox");
                    iaCheckboxCtrl.Enabled = false;
                    var iaApprovalCtrl = (RadioButtonList)(_formview).FindControl("_iaApproval");
                    iaApprovalCtrl.Enabled = false;

                    var saSubmitBtn = (Button)(_formview).FindControl("_saSubmit");
                    saSubmitBtn.Visible = false;
                    var saSamAccountCtrl = (TextBox)(_formview).FindControl("_samAccount");
                    saSamAccountCtrl.Enabled = false;
                    var saHomeFolderCtrl = (TextBox)(_formview).FindControl("_homeFolder");
                    saHomeFolderCtrl.Enabled = false;
                    var saRemarkCtrl = (TextBox)(_formview).FindControl("_saRemark");
                    saRemarkCtrl.Enabled = false;
                    var saCheckboxCtrl = (CheckBox)(_formview).FindControl("_saCheckBox");
                    saCheckboxCtrl.Enabled = false;
                    var saRequestStatusCtrl = (DropDownList)(_formview).FindControl("_editRequestStatus");
                    saRequestStatusCtrl.Enabled = false;

                    // Update defaults depending on the security group the current NEC employee is a member of.
                    if (User.IsInRole("CARSON NEC SSD SMB SA SG"))
                    {
                        saSubmitBtn.Visible = true;
                        saSamAccountCtrl.Enabled = true;
                        saHomeFolderCtrl.Enabled = true;
                        saRemarkCtrl.Enabled = true;
                        saCheckboxCtrl.Enabled = true;
                        saRequestStatusCtrl.Enabled = true;
                    }
                    if (User.IsInRole("CARSON NEC DSD Account Review"))
                    {
                        dsdSubmitBtn.Visible = true;
                        dsdRemarkCtrl.Enabled = true;
                        dsdCheckboxCtrl.Enabled = true;
                        dsdApprovalCtrl.Enabled = true;
                        dsdImoList.Enabled = true;
                    }
                    if (User.IsInRole("CARSON NEC IA Account Review"))
                    {
                        iaSubmitBtn.Visible = true;
                        iaRemarkCtrl.Enabled = true;
                        iaCheckboxCtrl.Enabled = true;
                        iaApprovalCtrl.Enabled = true;
                    }
                }
                else
                {
                    var saApprovalSection = (PlaceHolder)(_formview).FindControl("_saSection");
                    if (User.IsInRole("CARSON NEC SSD SMB SA SG"))
                    {
                        saApprovalSection.Visible = true;
                    }
                    else
                    {
                        saApprovalSection.Visible = false;
                    }
                    var iaSection = (PlaceHolder)(_formview).FindControl("_iaSection");
                    iaSection.Visible = false;
                    var dsdSection = (PlaceHolder)(_formview).FindControl("_dsdSection");
                    dsdSection.Visible = false;
                    var justificationSectionCtrl = (Panel)(_formview).FindControl("_justificationPanel");
                    justificationSectionCtrl.Visible = false;
                    var saRequestInfoSection = (Panel)(_formview).FindControl("_saPanel");
                    saRequestInfoSection.Visible = false;
                }
			}
		}

		protected void _formview_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
		{
			_gridview.DataBind();
			_formview.Visible = false;
		}

		protected void _searchButton_Click(object sender, EventArgs e)
		{
			_filterPanel.Visible = true;
			_gridview.Visible = true;
		}

		protected void _filter_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (IsPostBack)
			{
				_formview.Visible = false;
			}
		}

		protected void _gridview_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (IsPostBack)
			{
				_formview.Visible = true;
				_formview.DataBind();
			}
			else
			{
				_formview.Visible = false;
			}
		}

		protected void _gridview_PageIndexChanged(object sender, EventArgs e)
		{
			_formview.Visible = false;
		}

		protected void _cancelButton_Click(object sender, EventArgs e)
		{
			_formview.Visible = false;
			_formview.DataBind();
		}

        protected void _editRequestStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var saCheckBoxCtrl = (CheckBox)(_formview).FindControl("_saCheckBox");
                var saSignatureCtrl = (TextBox)(_formview).FindControl("_saSignature");

                saCheckBoxCtrl.Checked = false;
                saSignatureCtrl.Text = "";
            }
        }

        protected void _dsdApproval_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var dsdCheckBoxCtrl = (CheckBox)(_formview).FindControl("_dsdCheckBox");
                var dsdSignatureCtrl = (TextBox)(_formview).FindControl("_dsdSignature");

                dsdCheckBoxCtrl.Checked = false;
                dsdSignatureCtrl.Text = "";
            }
        }

        protected void _iaApproval_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var iaCheckBoxCtrl = (CheckBox)(_formview).FindControl("_iaCheckBox");
                var iaSignatureCtrl = (TextBox)(_formview).FindControl("_iaSignature");

                iaCheckBoxCtrl.Checked = false;
                iaSignatureCtrl.Text = "";
            }
        }

        protected void _dsd_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var dsdCheckBoxCtrl = (CheckBox)(_formview).FindControl("_dsdCheckBox");
                var dsdSignatureCtrl = (TextBox)(_formview).FindControl("_dsdSignature");

                if (dsdCheckBoxCtrl.Checked)
                {
                    dsdSignatureCtrl.Text = CacCard.Edipi;
                }
                else
                {
                    dsdSignatureCtrl.Text = "";
                }
            }
        }

        protected void _iA_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var iaCheckBoxCtrl = (CheckBox)(_formview).FindControl("_iaCheckBox");
                var iaSignatureCtrl = (TextBox)(_formview).FindControl("_iaSignature");

                if (iaCheckBoxCtrl.Checked)
                {
                    iaSignatureCtrl.Text = CacCard.Edipi;
                }
                else
                {
                    iaSignatureCtrl.Text = "";
                }
            }
        }

        protected void _sa_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var saCheckBoxCtrl = (CheckBox)(_formview).FindControl("_saCheckBox");
                var saNameCtrl = (TextBox)(_formview).FindControl("_saName");
                var saSignatureCtrl = (TextBox)(_formview).FindControl("_saSignature");

                if (saCheckBoxCtrl.Checked)
                {
                    saNameCtrl.Text = CacCard.FirstName + " " + CacCard.LastName;
                    saSignatureCtrl.Text = CacCard.Edipi;
                }
                else
                {
                    saNameCtrl.Text = "";
                    saSignatureCtrl.Text = "";
                }
            }
        }

        protected void _iaSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var modifiedDateCtrl = (TextBox)(_formview).FindControl("_modifiedDate");
                modifiedDateCtrl.Text = DateTime.Now.ToString();

                var iaDateSignedCtrl = (TextBox)(_formview).FindControl("_iaDateSigned");
                iaDateSignedCtrl.Text = DateTime.Now.ToString();

                var requestStatusCtrl = (TextBox)(_formview).FindControl("_requestStatus");
                var iaApprovalCtrl = (RadioButtonList)(_formview).FindControl("_iaApproval");
                var nameOfSender = CacCard.FirstName + " " + CacCard.LastName;
                string necEmailAddress;
                string necEmailMessage;
                var requestEdipi = (Literal)(_formview).FindControl("_edipi");
                var adminAppLink = "https://nec.carson.army.mil/accounts/sa-admin.aspx?search=" + requestEdipi.Text;
                var customerAppLink = "https://nec.carson.army.mil/accounts/verification.aspx?search=" + requestEdipi.Text;
                var accountType = (TextBox)(_formview).FindControl("_accountType");
                var iaRemarkCtrl = (TextBox)(_formview).FindControl("_iaRemark");
                var lineBreak = Environment.NewLine;
                var doubleLineBreak = Environment.NewLine + Environment.NewLine;

                if (IsSaCreateRequest)
                {
                    necEmailAddress = "kevin.w.smith110.civ@mail.mil, michael.j.hahn10.civ@mail.mil, miguel.gomez16.ctr@mail.mil";
                }
                else
                {
                    necEmailAddress = "usarmy.carson.106-sig-bde.list.nec-ssd-smb-sa@mail.mil, miguel.gomez16.ctr@mail.mil";
                }

                if (iaApprovalCtrl.SelectedValue == "Approved")
                {
                    requestStatusCtrl.Text = "IA Approved";
                    necEmailMessage = "This account has been approved by IA." + doubleLineBreak;
                    necEmailMessage += "IA Remarks:" + lineBreak + iaRemarkCtrl.Text;
                    Email.SendEmail(necEmailAddress, necEmailMessage, nameOfSender, adminAppLink, accountType.Text, false);
                }
                else
                {
                    requestStatusCtrl.Text = "Denied";
                    necEmailMessage = "This account has been denied by IA." + doubleLineBreak;
                    necEmailMessage += "IA Remarks:" + lineBreak + iaRemarkCtrl.Text;
                    Email.SendEmail(necEmailAddress, necEmailMessage, nameOfSender, adminAppLink, accountType.Text, false);

                    var customerEmailAddress = (Literal)(_formview).FindControl("_email");
                    var customerEmailMessage = "This account has been denied by IA. For more information, please contact Glen Wilson at glen.p.wilson.civ@mail.mil or Jeremy Cortez at jeremy.d.cortez.civ@mail.mil";
                    Email.SendEmail(customerEmailAddress.Text, customerEmailMessage, nameOfSender, customerAppLink, accountType.Text, false);
                }               
            }
        }

        protected void _dsdSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var modifiedDateCtrl = (TextBox)(_formview).FindControl("_modifiedDate");
                modifiedDateCtrl.Text = DateTime.Now.ToString();

                var dsdDateSignedCtrl = (TextBox)(_formview).FindControl("_dsdDateSigned");
                dsdDateSignedCtrl.Text = DateTime.Now.ToString();

                var requestStatusCtrl = (TextBox)(_formview).FindControl("_requestStatus");
                var dsdApprovalCtrl = (RadioButtonList)(_formview).FindControl("_dsdApproval");
                var requestEdipi = (Literal)(_formview).FindControl("_edipi");
                var iaRemarkCtrl = (TextBox)(_formview).FindControl("_iaRemark");
                var dsdRemarkCtrl = (TextBox)(_formview).FindControl("_dsdRemark");
                string necEmailMessage;
                var nameOfSender = CacCard.FirstName + " " + CacCard.LastName;
                var adminAppLink = "https://nec.carson.army.mil/accounts/sa-admin.aspx?search=" + requestEdipi.Text;
                var customerAppLink = "https://nec.carson.army.mil/accounts/verification.aspx?search=" + requestEdipi.Text;
                var accountType = (TextBox)(_formview).FindControl("_accountType");
                var lineBreak = Environment.NewLine;
                var doubleLineBreak = Environment.NewLine + Environment.NewLine;

                if (dsdApprovalCtrl.SelectedValue == "Approved")
                {
                    requestStatusCtrl.Text = "DSD Approved";
                    var necEmailAddress = "usarmy.carson.106-sig-bde.list.nec-ssd-smb-sa@mail.mil, glen.p.wilson.civ@mail.mil, jeremy.d.cortez.civ@mail.mil, miguel.gomez16.ctr@mail.mil";
                    necEmailMessage = "This account has been approved by DSD." + doubleLineBreak;
                    necEmailMessage += "DSD Remarks:" + lineBreak + dsdRemarkCtrl.Text + doubleLineBreak;
                    necEmailMessage += "IA Remarks:" + lineBreak + iaRemarkCtrl.Text;

                    Email.SendEmail(necEmailAddress, necEmailMessage, nameOfSender, adminAppLink, accountType.Text, false);
                }
                else
                {
                    requestStatusCtrl.Text = "Denied";
                    var necEmailAddress = "glen.p.wilson.civ@mail.mil, jeremy.d.cortez.civ@mail.mil, miguel.gomez16.ctr@mail.mil";
                    necEmailMessage = "This account has been denied by DSD." + doubleLineBreak;
                    necEmailMessage += "DSD Remarks:" + lineBreak + dsdRemarkCtrl.Text;
                    Email.SendEmail(necEmailAddress, necEmailMessage, nameOfSender, adminAppLink, accountType.Text, false);

                    var customerEmailAddress = (Literal)(_formview).FindControl("_email");
                    var customerEmailMessage = "This account has been denied by DSD. For more information, please contact Kevin Smith at kevin.w.smith110.civ@mail.mil";
                    Email.SendEmail(customerEmailAddress.Text, customerEmailMessage, nameOfSender, customerAppLink, accountType.Text, false);
                }
            }
        }

        protected void _saSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var modifiedDateCtrl = (TextBox)(_formview).FindControl("_modifiedDate");
                modifiedDateCtrl.Text = DateTime.Now.ToString();

                var saDateSignedCtrl = (TextBox)(_formview).FindControl("_saDateSigned");
                saDateSignedCtrl.Text = DateTime.Now.ToString();

                var requestStatusCtrl = (TextBox)(_formview).FindControl("_requestStatus");
                var editRequestStatusCtrl = (DropDownList)(_formview).FindControl("_editRequestStatus");
                requestStatusCtrl.Text = editRequestStatusCtrl.SelectedValue;
                var nameOfSender = CacCard.FirstName + " " + CacCard.LastName;
                string emailMessage;
                var requestEdipi = (Literal)(_formview).FindControl("_edipi");
                var appLink = "https://nec.carson.army.mil/accounts/sa-admin.aspx?search=" + requestEdipi.Text;
                var accountType = (TextBox)(_formview).FindControl("_accountType");
                var lineBreak = Environment.NewLine;
                var doubleLineBreak = Environment.NewLine + Environment.NewLine;
                var saRemarkCtrl = (TextBox)(_formview).FindControl("_saRemark");
                var iaRemarkCtrl = (TextBox)(_formview).FindControl("_iaRemark");
                var dsdRemarkCtrl = (TextBox)(_formview).FindControl("_dsdRemark");
                
                string necEmailAddress;
                if (IsSaCreateRequest)
                {
                    necEmailAddress = "kevin.w.smith110.civ@mail.mil, michael.j.hahn10.civ@mail.mil, glen.p.wilson.civ@mail.mil, jeremy.d.cortez.civ@mail.mil, miguel.gomez16.ctr@mail.mil";
                }
                else
                {
                    necEmailAddress = "glen.p.wilson.civ@mail.mil, jeremy.d.cortez.civ@mail.mil, miguel.gomez16.ctr@mail.mil";
                }

                if (editRequestStatusCtrl.SelectedValue == "Completed" && (IsSaCreateRequest || IsEpCreateRequest))
                {
                    var completedDateCtrl = (TextBox)(_formview).FindControl("_completedDate");
                    completedDateCtrl.Text = DateTime.Now.ToString();
                    emailMessage = "This account has been created by the SA section." + doubleLineBreak;
                    emailMessage += "SA Remarks:" + lineBreak + saRemarkCtrl.Text + doubleLineBreak;
                    Email.SendEmail(necEmailAddress, emailMessage, nameOfSender, appLink, accountType.Text, false);
                }
                else if (editRequestStatusCtrl.SelectedValue == "Denied" && (IsSaCreateRequest || IsEpCreateRequest))
                {
                    emailMessage = "This account has been denied by the SA section." + doubleLineBreak;
                    emailMessage += "SA Remarks:" + lineBreak + saRemarkCtrl.Text + doubleLineBreak;
                    Email.SendEmail(necEmailAddress, emailMessage, nameOfSender, appLink, accountType.Text, false);
                }          
            }
        }
    }
}