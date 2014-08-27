using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AccountCreation
{
	public partial class Verification : System.Web.UI.Page
	{
        private bool RequiresTwoSignatures
        {
            get
            {
                var accountTypeControl = (TextBox)(_formview).FindControl("_accountType");
                var requestTypeControl = (TextBox)(_formview).FindControl("_requestType");
                if (requestTypeControl.Text.Contains("Delete") || accountTypeControl.Text == "VPN")
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }
        
		protected void Page_Load(object sender, EventArgs e)
		{
			var seachQueryString = Request.QueryString["search"];

			if (!IsPostBack && seachQueryString != null)
			{
				_gridview.Visible = true;
				_searchBox.Text = seachQueryString;
			}
		}

		protected void _searchButton_Click(object sender, EventArgs e)
		{
			_gridview.Visible = true;
			_formview.Visible = false;
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

		protected void _formview_DataBound(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Edit)
			{
                var accountTypeControl = (TextBox)(_formview).FindControl("_accountType");
                var requestTypeControl = (TextBox)(_formview).FindControl("_requestType");

                var supSubmitBtnCtrl = (Button)(_formview).FindControl("_supSubmitBtn");
                var secSubmitBtnCtrl = (Button)(_formview).FindControl("_secSubmitBtn");
                var supervisorSignatureControl = (TextBox)(_formview).FindControl("_supervisorSignature");
                var supervisorCheckBoxControl = (CheckBox)(_formview).FindControl("_supervisorCheckBox");

                if (RequiresTwoSignatures)
                {
                    CheckBox securityCheckBoxControl = (CheckBox)(_formview).FindControl("_securityCheckBox");
                    PlaceHolder securityBoxPlaceholderControl = (PlaceHolder)(_formview).FindControl("_securityBoxPlaceholder");

                    if (supervisorCheckBoxControl.Checked && securityBoxPlaceholderControl.Visible == false)
                    {
                        securityBoxPlaceholderControl.Visible = true;
                    }

                    if (securityBoxPlaceholderControl.Visible == true)
                    {
                        var investigationDateRangeValidator = (RangeValidator)(_formview).FindControl("_investigationDateRangeValidator");
                        investigationDateRangeValidator.MinimumValue = DateTime.Today.AddYears(-10).ToShortDateString();
                        investigationDateRangeValidator.MaximumValue = DateTime.Today.ToShortDateString();
                        investigationDateRangeValidator.Type = ValidationDataType.Date;
                    }

                    if (supervisorCheckBoxControl.Checked)
                    {
                        supervisorCheckBoxControl.Enabled = false;
                        supSubmitBtnCtrl.Visible = false;
                    }

                    if (securityCheckBoxControl.Checked)
                    {
                        securityCheckBoxControl.Enabled = false;
                        secSubmitBtnCtrl.Visible = false;
                    }
                }
                else if (supervisorCheckBoxControl.Checked)
                {
                    supervisorCheckBoxControl.Enabled = false;
                    supSubmitBtnCtrl.Visible = false;
                }

                if (requestTypeControl.Text == "Manual Delete" || requestTypeControl.Text == "Auto Delete")
                {
                    var deleteDatePanelControl = (Panel)(_formview).FindControl("_deleteRequestPanel");
                    deleteDatePanelControl.Visible = true;

                    var deleteDateRangeValidator = (RangeValidator)(_formview).FindControl("_deleteDateRangeValidator"); 
                    deleteDateRangeValidator.MinimumValue = DateTime.Today.ToShortDateString();
                    deleteDateRangeValidator.MaximumValue = DateTime.Today.AddMonths(2).ToShortDateString();
                    deleteDateRangeValidator.Type = ValidationDataType.Date;
                }

                if (requestTypeControl.Text.Contains("Create") &&  (accountTypeControl.Text == "SA" || accountTypeControl.Text == "EP"))
                {
                    var saPanelControl = (Panel)(_formview).FindControl("_saPanel");
                    saPanelControl.Visible = true;

                    var justificationPanelControl = (Panel)(_formview).FindControl("_justificationPanel");
                    justificationPanelControl.Visible = true;

                    var unitListControl = (ListBox)(_formview).FindControl("_unitList");
                    foreach (string item in Setting.OrgUnit)
                    {
                        unitListControl.Items.Add(new ListItem(item, item));
                    }
                }

                var installationControl = (DropDownList)(_formview).FindControl("_installation");
                var personaControl = (DropDownList)(_formview).FindControl("_persona");
                var macomControl = (DropDownList)(_formview).FindControl("_macom");
                var branchControl = (DropDownList)(_formview).FindControl("_branch");
                var orgUnitControl = (DropDownList)(_formview).FindControl("_orgUnit");
                var rankControl = (DropDownList)(_formview).FindControl("_rank");

                foreach (string item in Setting.Macom)
				{
					if (macomControl.SelectedValue == item)
					{
						continue;
					}
					macomControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Installation)
				{
					if (installationControl.SelectedValue == item)
					{
						continue;
					}
					installationControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Persona)
				{
					if (personaControl.SelectedValue == item)
					{
						continue;
					}
					personaControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Rank)
				{
					if (rankControl.SelectedValue == item)
					{
						continue;
					}
					rankControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.OrgUnit)
				{
					if (orgUnitControl.SelectedValue == item)
					{
						continue;
					}
					orgUnitControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Branch)
				{
					if (branchControl.SelectedValue == item)
					{
						continue;
					}
					branchControl.Items.Add(new ListItem(item, item));
				}
			}
		}

		protected void _formview_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
		{
			_gridview.DataBind();
			_formview.Visible = false;
		}

		protected void _supervisor_CheckBox_CheckedChanged(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Edit)
			{
				var supervisorCheckBoxControl = (CheckBox)(_formview).FindControl("_supervisorCheckBox");
				var supervisorSignatureControl = (TextBox)(_formview).FindControl("_supervisorSignature");

				if (supervisorCheckBoxControl.Checked)
				{
					supervisorSignatureControl.Text = CacCard.Edipi;
				}
				else
				{
					supervisorSignatureControl.Text = "";
				}
			}
		}

		protected void _security_CheckBox_CheckedChanged(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Edit)
			{
				var securityCheckBoxControl = (CheckBox)(_formview).FindControl("_securityCheckBox");
				var securitySignatureControl = (TextBox)(_formview).FindControl("_securitySignature");

                if (securityCheckBoxControl.Checked)
				{
					securitySignatureControl.Text = CacCard.Edipi;
				}
				else
				{
					securitySignatureControl.Text = "";
				}
			}
		}

		protected void _cancelButton_Click(object sender, EventArgs e)
		{
			_formview.Visible = false;
			_formview.DataBind();
		}

        protected void _supSubmitBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var supSignedDateControl = (TextBox)(_formview).FindControl("_supSignedDate");
                supSignedDateControl.Text = DateTime.Now.ToString();

                var requestStatusControl = (TextBox)(_formview).FindControl("_requestStatus");
         
                if (RequiresTwoSignatures)
                {
                    requestStatusControl.Text = "Partially Verified";
                }
                else
                {
                    requestStatusControl.Text = "Ready";
                }
            }
        }

        protected void _secSubmitBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var secSignedDateControl = (TextBox)(_formview).FindControl("_secSignedDate");
                secSignedDateControl.Text = DateTime.Now.ToString();

                var requestStatusControl = (TextBox)(_formview).FindControl("_requestStatus");
                requestStatusControl.Text = "Ready";

                var accountType = (TextBox)(_formview).FindControl("_accountType");

                if (accountType.Text == "SA")
                {
                    var fName = (TextBox)(_formview).FindControl("_fName");
                    var lName = (TextBox)(_formview).FindControl("_lName");
                    var userName = fName.Text + " " + lName.Text;
                    var iaEmail = "glen.p.wilson.civ@mail.mil, jeremy.d.cortez.civ@mail.mil, miguel.gomez16.ctr@mail.mil";
                    // TODO: FIND out how to set defaults if blank
                    var iaMessage = "Use the link below to review this request.";
                    var iaLink = "https://nec.carson.army.mil/accounts/sa-admin.aspx?search=" + CacCard.Edipi;
                    Email.SendEmail(iaEmail, iaMessage, userName, iaLink, accountType.Text, false);
                }
            }
        }

	}
}