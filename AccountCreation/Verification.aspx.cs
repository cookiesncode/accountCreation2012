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

                Button updateButtonControl = null;
                var supervisorSignatureControl = (TextBox)(_formview).FindControl("_supervisorSignature");
                var supervisorCheckBoxControl = (CheckBox)(_formview).FindControl("_supervisorCheckBox");

                if (RequiresTwoSignatures)
                {
                    CheckBox securityCheckBoxControl = null;
                    PlaceHolder securityBoxPlaceholderControl = (PlaceHolder)(_formview).FindControl("_securityBoxPlaceholder");

                    var investigationDateRangeValidator = (RangeValidator)(_formview).FindControl("_investigationDateRangeValidator");
                    investigationDateRangeValidator.MinimumValue = DateTime.Today.AddYears(-5).ToShortDateString();
                    investigationDateRangeValidator.MaximumValue = DateTime.Today.ToShortDateString();
                    investigationDateRangeValidator.Type = ValidationDataType.Date;

                    if (supervisorCheckBoxControl.Checked && !securityBoxPlaceholderControl.Visible)
                    {
                        supervisorCheckBoxControl.Enabled = false;
                        securityBoxPlaceholderControl.Visible = true;
                        securityCheckBoxControl = (CheckBox)(_formview).FindControl("_securityCheckBox");
                    }
                    if (securityBoxPlaceholderControl.Visible && securityCheckBoxControl.Checked)
                    {
                        securityCheckBoxControl.Enabled = false;
                    }
                    if (supervisorCheckBoxControl.Checked && securityBoxPlaceholderControl.Visible && securityCheckBoxControl.Checked)
                    {
                        updateButtonControl = (Button)(_formview).FindControl("_updateButton");
                        updateButtonControl.Visible = false;
                    }
                }
                else if (supervisorCheckBoxControl.Checked)
                {
                    supervisorCheckBoxControl.Enabled = false;
                    updateButtonControl = (Button)(_formview).FindControl("_updateButton");
                    updateButtonControl.Visible = false;
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

                if (requestTypeControl.Text.Contains("Create") && accountTypeControl.Text == "EP")
                {
                    var epPanelControl = (Panel)(_formview).FindControl("_epPanel");
                    epPanelControl.Visible = true;

                    var epUnitsControl = (ListBox)(_formview).FindControl("_epUnitsList");
                    foreach (string item in Setting.OrgUnit)
                    {
                        epUnitsControl.Items.Add(new ListItem(item, item));
                    }
                }

                if (requestTypeControl.Text.Contains("Create") &&  (accountTypeControl.Text == "SA" || accountTypeControl.Text == "EP"))
                {
                    var justificationPanelControl = (Panel)(_formview).FindControl("_justificationPanel");
                    justificationPanelControl.Visible = true;
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

		protected void _middleInitialValidator_ServerValidate(object source, ServerValidateEventArgs args)
		{
			if (args.Value.Length > 1)
			{
				args.IsValid = false;
			}
			else
			{
				args.IsValid = true;
			}
		}

		protected void _supervisor_CheckBox_CheckedChanged(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Edit)
			{
				var supervisorCheckBoxControl = (CheckBox)(_formview).FindControl("_supervisorCheckBox");
				var supervisorSignatureControl = (TextBox)(_formview).FindControl("_supervisorSignature");
				var supSignedDateControl = (TextBox)(_formview).FindControl("_supSignedDate");
				var supSignedControl = (CheckBox)(_formview).FindControl("_supSigned");
				var requestStatusControl = (TextBox)(_formview).FindControl("_requestStatus");

				if (supervisorCheckBoxControl.Checked)
				{
					supervisorSignatureControl.Text = CacCard.Edipi;
					supSignedDateControl.Text = DateTime.Now.ToString();
					supSignedControl.Checked = true;
                    if (RequiresTwoSignatures)
                    {
                        requestStatusControl.Text = "Partially Verified";
                    }
                    else
                    {
                        requestStatusControl.Text = "Ready";
                    }
				}
				else
				{
					supervisorSignatureControl.Text = "";
					supSignedDateControl.Text = "";
					supSignedControl.Checked = false;
					requestStatusControl.Text = "";
				}
			}
		}

		protected void _security_CheckBox_CheckedChanged(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Edit)
			{
				var securityCheckBoxControl = (CheckBox)(_formview).FindControl("_securityCheckBox");
				var securitySignatureControl = (TextBox)(_formview).FindControl("_securitySignature");
				var secSignedDateControl = (TextBox)(_formview).FindControl("_secSignedDate");
				var secSignedControl = (CheckBox)(_formview).FindControl("_secSigned");
                var requestStatusControl = (TextBox)(_formview).FindControl("_requestStatus");

                if (securityCheckBoxControl.Checked)
				{
					securitySignatureControl.Text = CacCard.Edipi;
					secSignedDateControl.Text = DateTime.Now.ToString();
					secSignedControl.Checked = true;
                    requestStatusControl.Text = "Ready";
				}
				else
				{
					securitySignatureControl.Text = "";
					secSignedDateControl.Text = "";
					secSignedControl.Checked = false;
                    requestStatusControl.Text = "";
				}
			}
		}

		protected void _cancelButton_Click(object sender, EventArgs e)
		{
			_formview.Visible = false;
			_formview.DataBind();
		}

	}
}