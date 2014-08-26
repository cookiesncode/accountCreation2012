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
        private bool RequiresThreeSignatures
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

		protected void Page_Load(object sender, EventArgs e)
		{
            if (Page.User.IsInRole("CARSON NEC SSD SMB SA SG") || Page.User.IsInRole("CARSON NEC IA Account Review"))
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
                var accountTypeControl = (TextBox)(_formview).FindControl("_accountType");
                var requestTypeControl = (TextBox)(_formview).FindControl("_requestType");
                var submitBtn = (Button)(_formview).FindControl("_updateButton");
                submitBtn.Visible = false;

                if (User.IsInRole("CARSON NEC SSD SMB SA SG"))
                {
                    submitBtn.Visible = true;
                }
               
                if (User.IsInRole("CARSON NEC IA Account Review") && RequiresThreeSignatures)
                {
                    submitBtn.Visible = true;
                }
                
                if (requestTypeControl.Text == "Manual Delete" || requestTypeControl.Text == "Auto Delete")
                {
                    var deleteDatePanelControl = (Panel)(_formview).FindControl("_deleteRequestPanel");
                    deleteDatePanelControl.Visible = true;
                }

                if (accountTypeControl.Text != "NIPR")
				{
                    var adContainerControl = (PlaceHolder)(_formview).FindControl("_adInfo");
                    adContainerControl.Visible = true;
				}

                if (RequiresThreeSignatures)
                {
                    var supervisorNameCtrl = (Literal)(_formview).FindControl("_supervisorName");
                    var supervisorEdipiCtrl = (TextBox)(_formview).FindControl("_supervisorEdipi");
                    var supervisorInfo = AdAccount.FindAdUser(supervisorEdipiCtrl.Text);
                    supervisorNameCtrl.Text = supervisorInfo;

                    var requestEntryJustificationCtrl = (Panel)(_formview).FindControl("_justificationPanel");
                    requestEntryJustificationCtrl.Visible = true;

                    var requestEntrySaCtrl = (Panel)(_formview).FindControl("_saPanel");
                    requestEntrySaCtrl.Visible = true;

                    var saApprovalSection = (PlaceHolder)(_formview).FindControl("_saSection");
                    saApprovalSection.Visible = false;

                    var iaApprovalSection = (PlaceHolder)(_formview).FindControl("_iaSection");
                    iaApprovalSection.Visible = false;

                    var dsdApprovalSection = (PlaceHolder)(_formview).FindControl("_dsdSection");
                    dsdApprovalSection.Visible = true;
                                  
                    var requestStatusCtrl = (TextBox)(_formview).FindControl("_requestStatus");
                    var dsdCheckBoxCtrl = (CheckBox)(_formview).FindControl("_dsdCheckBox");

                    if ((requestStatusCtrl.Text.Contains("Pending") == true || requestStatusCtrl.Text.Contains("Approved") || requestStatusCtrl.Text.Contains("Completed")) && dsdCheckBoxCtrl.Checked)
                    {
                        iaApprovalSection.Visible = true;
                    }

                    var iaCheckBoxCtrl = (CheckBox)(_formview).FindControl("_iaCheckBox");

                    if ((requestStatusCtrl.Text.Contains("Approved") || requestStatusCtrl.Text.Contains("Completed") == true) && iaCheckBoxCtrl.Checked)
                    {
                        saApprovalSection.Visible = true;
                    }
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
                var editRequestStatusCtrl = (DropDownList)(_formview).FindControl("_editRequestStatus");
                var requestStatusCtrl = (TextBox)(_formview).FindControl("_requestStatus");
                var completedDateCtrl = (TextBox)(_formview).FindControl("_completedDate");
                var modifiedDateCtrl = (TextBox)(_formview).FindControl("_modifiedDate");
                var saCheckBoxCtrl = (CheckBox)(_formview).FindControl("_saCheckBox");
                var saSignatureCtrl = (TextBox)(_formview).FindControl("_saSignature");

                saCheckBoxCtrl.Checked = false;
                saSignatureCtrl.Text = "";
                requestStatusCtrl.Text = editRequestStatusCtrl.SelectedValue;

                if (editRequestStatusCtrl.SelectedValue == "Completed" || editRequestStatusCtrl.SelectedValue == "Denied")
                {
                    completedDateCtrl.Text = DateTime.Now.ToString();
                    modifiedDateCtrl.Text = "";
                }
                else
                {
                    modifiedDateCtrl.Text = DateTime.Now.ToString();
                    completedDateCtrl.Text = "";
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
                var saDateSignedCtrl = (TextBox)(_formview).FindControl("_saDateSigned");

                if (saCheckBoxCtrl.Checked)
                {
                    saNameCtrl.Text = CacCard.FirstName + " " + CacCard.LastName;
                    saSignatureCtrl.Text = CacCard.Edipi;
                    saDateSignedCtrl.Text = DateTime.Now.ToString();
                }
                else
                {
                    saNameCtrl.Text = "";
                    saSignatureCtrl.Text = "";
                    saDateSignedCtrl.Text = "";
                }
            }
        }

        protected void _iA_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var iaCheckBoxCtrl = (CheckBox)(_formview).FindControl("_iaCheckBox");
                var iaSignatureCtrl = (TextBox)(_formview).FindControl("_iaSignature");
                var iaDateSignedCtrl = (TextBox)(_formview).FindControl("_iaDateSigned");
                var requestStatusCtrl = (TextBox)(_formview).FindControl("_requestStatus");
                
                if (iaCheckBoxCtrl.Checked)
                {
                    var iaApprovalControl = (RadioButtonList)(_formview).FindControl("_iaApproval");

                    if (iaApprovalControl.SelectedValue == "Denied")
                    {
                        requestStatusCtrl.Text = "Denied";
                    }
                    else
                    {
                        requestStatusCtrl.Text = "Approved";
                    }
                    iaSignatureCtrl.Text = CacCard.Edipi;
                    iaDateSignedCtrl.Text = DateTime.Now.ToString();
                }
                else
                {
                    iaSignatureCtrl.Text = "";
                    iaDateSignedCtrl.Text = "";
                    requestStatusCtrl.Text = "Pending";
                }
            }
        }

        protected void _dsd_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var dsdCheckBoxCtrl = (CheckBox)(_formview).FindControl("_dsdCheckBox");
                var dsdSignatureCtrl = (TextBox)(_formview).FindControl("_dsdSignature");
                var dsdDateSignedCtrl = (TextBox)(_formview).FindControl("_dsdDateSigned");
                var requestStatusCtrl = (TextBox)(_formview).FindControl("_requestStatus");       

                if (dsdCheckBoxCtrl.Checked)
                {
                    var dsdApprovalControl = (RadioButtonList)(_formview).FindControl("_dsdApproval");

                    if (dsdApprovalControl.SelectedValue == "Denied")
                    {
                        requestStatusCtrl.Text = "Denied";
                    }
                    else
                    {
                        requestStatusCtrl.Text = "Pending";
                    }
                    dsdSignatureCtrl.Text = CacCard.Edipi;
                    dsdDateSignedCtrl.Text = DateTime.Now.ToString();
                }
                else
                {
                    dsdSignatureCtrl.Text = "";
                    dsdDateSignedCtrl.Text = "";
                    requestStatusCtrl.Text = "Requested";
                }
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
    }
}