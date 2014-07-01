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
				var installationControl = (DropDownList)(_formview).FindControl("_installation");
				var personaControl = (DropDownList)(_formview).FindControl("_persona");
				var macomControl = (DropDownList)(_formview).FindControl("_macom");
				var branchControl = (DropDownList)(_formview).FindControl("_branch");
				var orgUnitControl = (DropDownList)(_formview).FindControl("_orgUnit");
				var rankControl = (DropDownList)(_formview).FindControl("_rank");
				var supervisorSignatureControl = (TextBox)(_formview).FindControl("_supervisorSignature");
				var supervisorCheckBoxControl = (CheckBox)(_formview).FindControl("_supervisorCheckBox");
                var accountTypeControl = (TextBox)(_formview).FindControl("_accountType");
                var requestTypeControl = (TextBox)(_formview).FindControl("_requestType");
                var epUnitsControl = (ListBox)(_formview).FindControl("_epUnitsList");
				var epPanelControl = (Panel)(_formview).FindControl("_epPanel");
				Button updateButtonControl = null;
				CheckBox securityCheckBoxControl = null;
				TextBox securitySignatureControl = null;
				PlaceHolder securityBoxPlaceholderControl = (PlaceHolder)(_formview).FindControl("_securityBoxPlaceholder");

                if (RequiresTwoSignatures)
                {
                    if (supervisorSignatureControl.Text.Length > 0 && securitySignatureControl == null)
                    {
                        supervisorCheckBoxControl.Enabled = false;
                        supervisorCheckBoxControl.Checked = true;
                        securityBoxPlaceholderControl.Visible = true;
                        securitySignatureControl = (TextBox)(_formview).FindControl("_securitySignature");
                        securityCheckBoxControl = (CheckBox)(_formview).FindControl("_securityCheckBox");
                    }
                    if (securitySignatureControl != null && securitySignatureControl.Text.Length > 0)
                    {
                        securityCheckBoxControl.Enabled = false;
                        securityCheckBoxControl.Checked = true;
                    }
                    if (supervisorCheckBoxControl.Checked && securityCheckBoxControl != null && securityCheckBoxControl.Checked)
                    {
                        updateButtonControl = (Button)(_formview).FindControl("_updateButton");
                        updateButtonControl.Visible = false;
                    }
                }
                else if (supervisorSignatureControl.Text.Length > 0)
                {
                    supervisorCheckBoxControl.Enabled = false;
                    supervisorCheckBoxControl.Checked = true;
                    updateButtonControl = (Button)(_formview).FindControl("_updateButton");
                    updateButtonControl.Visible = false;
                }

                if (accountTypeControl.Text == "EP")
                {
                    epPanelControl.Visible = true;
                    foreach (string item in Setting.OrgUnit)
                    {
                        epUnitsControl.Items.Add(new ListItem(item, item));
                    }
                }

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
				var acctStatusControl = (TextBox)(_formview).FindControl("_acctStatus");

				if (supervisorCheckBoxControl.Checked)
				{
					supervisorSignatureControl.Text = CacCard.Edipi;
					supSignedDateControl.Text = DateTime.Now.ToString();
					supSignedControl.Checked = true;
                    if (RequiresTwoSignatures)
                    {
                        acctStatusControl.Text = "Partially Verified";
                    }
                    else
                    {
                        acctStatusControl.Text = "Ready";
                    }
				}
				else
				{
					supervisorSignatureControl.Text = "";
					supSignedDateControl.Text = "";
					supSignedControl.Checked = false;
					acctStatusControl.Text = "";
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
				var acctStatusControl = (TextBox)(_formview).FindControl("_acctStatus");

                if (securityCheckBoxControl.Checked)
				{
					securitySignatureControl.Text = CacCard.Edipi;
					secSignedDateControl.Text = DateTime.Now.ToString();
					secSignedControl.Checked = true;
					acctStatusControl.Text = "Ready";
				}
				else
				{
					securitySignatureControl.Text = "";
					secSignedDateControl.Text = "";
					secSignedControl.Checked = false;
					acctStatusControl.Text = "";
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