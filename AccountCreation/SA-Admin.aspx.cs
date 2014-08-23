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
                var accountTypeControl = (TextBox)(_formview).FindControl("_accountType");
                var requestTypeControl = (TextBox)(_formview).FindControl("_requestType");
                if (requestTypeControl.Text.Contains("Create") && accountTypeControl.Text == "SA")
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
                if (User.IsInRole("CARSON NEC IA Account Review") && (accountTypeControl.Text == "SA" || accountTypeControl.Text == "EP"))
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

                if (requestTypeControl.Text.Contains("Create") && accountTypeControl.Text == "SA")
                {
                    var saSection = (PlaceHolder)(_formview).FindControl("_saSection");
                    saSection.Visible = false;

                    var iaSection = (PlaceHolder)(_formview).FindControl("_iaSection");
                    iaSection.Visible = false;

                    var dsdSection = (PlaceHolder)(_formview).FindControl("_dsdSection");
                    dsdSection.Visible = true;

                    var saCheckBox = (CheckBox)(_formview).FindControl("_saCheckBox");
                    var iaCheckBox = (CheckBox)(_formview).FindControl("_iaCheckBox");
                    var dsdCheckBox = (CheckBox)(_formview).FindControl("_dsdCheckBox");
                    var requestStatusControl = (TextBox)(_formview).FindControl("_requestStatus");
                    var dsdApprovalValidator = (RequiredFieldValidator)(_formview).FindControl("_dsdApprovalRequiredValidator");
                    var iaApprovalValidator = (RequiredFieldValidator)(_formview).FindControl("_iaApprovalRequiredValidator");

                    if ((requestStatusControl.Text.Contains("Pending") == true || requestStatusControl.Text.Contains("Approved") || requestStatusControl.Text.Contains("Completed")) && dsdCheckBox.Checked)
                    {
                        iaSection.Visible = true;
                        dsdApprovalValidator.Visible = false;
                    }
                    if ((requestStatusControl.Text.Contains("Approved") || requestStatusControl.Text.Contains("Completed") == true) && iaCheckBox.Checked)
                    {
                        saSection.Visible = true;
                        iaApprovalValidator.Visible = false;
                    }

                    var justificationPanelControl = (Panel)(_formview).FindControl("_justificationPanel");
                    justificationPanelControl.Visible = true;
                    
                    var saPanelControl = (Panel)(_formview).FindControl("_saPanel");
                    saPanelControl.Visible = true;

                    var supervisorNameControl = (Literal)(_formview).FindControl("_supervisorName");
                    var supervisorEdipiControl = (TextBox)(_formview).FindControl("_supervisorEdipi");
                    var supervisorInfo = AdAccount.FindAdUser(supervisorEdipiControl.Text);
                    supervisorNameControl.Text = supervisorInfo;
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
                var editRequestStatus = (DropDownList)(_formview).FindControl("_editRequestStatus");
                var requestStatusControl = (TextBox)(_formview).FindControl("_requestStatus");
                var completedDate = (TextBox)(_formview).FindControl("_completedDate");
                var modifiedDate = (TextBox)(_formview).FindControl("_modifiedDate");
                var saCheckBoxControl = (CheckBox)(_formview).FindControl("_saCheckBox");
                var saSignatureControl = (TextBox)(_formview).FindControl("_saSignature");

                saCheckBoxControl.Checked = false;
                saSignatureControl.Text = "";
                requestStatusControl.Text = editRequestStatus.SelectedValue;

                if (editRequestStatus.SelectedValue == "Completed" || editRequestStatus.SelectedValue == "Denied")
                {
                    completedDate.Text = DateTime.Now.ToString();
                    modifiedDate.Text = "";
                }
                else
                {
                    modifiedDate.Text = DateTime.Now.ToString();
                    completedDate.Text = "";
                }
            }
        }

        protected void _sa_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var saCheckBox = (CheckBox)(_formview).FindControl("_saCheckBox");
                var saName = (TextBox)(_formview).FindControl("_saName");
                var saSignature = (TextBox)(_formview).FindControl("_saSignature");
                var saDateSignedControl = (TextBox)(_formview).FindControl("_saDateSigned");

                if (saCheckBox.Checked)
                {
                    saName.Text = CacCard.FirstName + " " + CacCard.LastName;
                    saSignature.Text = CacCard.Edipi;
                    saDateSignedControl.Text = DateTime.Now.ToString();
                }
                else
                {
                    saName.Text = "";
                    saSignature.Text = "";
                    saDateSignedControl.Text = "";
                }
            }
        }

        protected void _iA_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var iaCheckBoxControl = (CheckBox)(_formview).FindControl("_iaCheckBox");
                var iaSignatureControl = (TextBox)(_formview).FindControl("_iaSignature");
                var iaDateSignedControl = (TextBox)(_formview).FindControl("_iaDateSigned");
                var requestStatusControl = (TextBox)(_formview).FindControl("_requestStatus");
                var iaApprovalControl = (RadioButtonList)(_formview).FindControl("_iaApproval");

                if (iaCheckBoxControl.Checked)
                {
                    if (iaApprovalControl.SelectedValue == "Denied")
                    {
                        requestStatusControl.Text = "Denied";
                    }
                    else
                    {
                        requestStatusControl.Text = "Approved";
                    }
                    iaSignatureControl.Text = CacCard.Edipi;
                    iaDateSignedControl.Text = DateTime.Now.ToString();
                }
                else
                {
                    iaSignatureControl.Text = "";
                    iaDateSignedControl.Text = "";
                    requestStatusControl.Text = "Pending";
                }
            }
        }

        protected void _dsd_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var dsdCheckBoxControl = (CheckBox)(_formview).FindControl("_dsdCheckBox");
                var dsdSignatureControl = (TextBox)(_formview).FindControl("_dsdSignature");
                var dsdDateSignedControl = (TextBox)(_formview).FindControl("_dsdDateSigned");
                var requestStatusControl = (TextBox)(_formview).FindControl("_requestStatus");
                var dsdApprovalControl = (RadioButtonList)(_formview).FindControl("_dsdApproval");

                if (dsdCheckBoxControl.Checked)
                {
                    if (dsdApprovalControl.SelectedValue == "Denied")
                    {
                        requestStatusControl.Text = "Denied";
                    }
                    else
                    {
                        requestStatusControl.Text = "Pending";
                    }
                    dsdSignatureControl.Text = CacCard.Edipi;
                    dsdDateSignedControl.Text = DateTime.Now.ToString();
                }
                else
                {
                    dsdSignatureControl.Text = "";
                    dsdDateSignedControl.Text = "";
                    requestStatusControl.Text = "Requested";
                }
            }
        }

        protected void _dsdApproval_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var dsdCheckBoxControl = (CheckBox)(_formview).FindControl("_dsdCheckBox");
                var dsdSignatureControl = (TextBox)(_formview).FindControl("_dsdSignature");

                dsdCheckBoxControl.Checked = false;
                dsdSignatureControl.Text = "";
            }

        }

        protected void _iaApproval_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var iaCheckBoxControl = (CheckBox)(_formview).FindControl("_iaCheckBox");
                var iaSignatureControl = (TextBox)(_formview).FindControl("_iaSignature");

                iaCheckBoxControl.Checked = false;
                iaSignatureControl.Text = "";
            }
        }
    }
}