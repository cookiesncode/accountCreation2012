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
		CurrentUser user;

		protected void Page_Load(object sender, EventArgs e)
		{
			var cert = Request.ClientCertificate;
			var seachQueryString = Request.QueryString["search"];

			if (cert.IsPresent)
			{
				user = new CurrentUser(cert);
			}
			else
			{
				// Local testing only. Does not output card info to textboxes!!
				user = new CurrentUser("1265020972");
			}

			if (!IsPostBack && seachQueryString != null)
			{
				_verifyForm.Visible = true;
				_searchBox.Text = seachQueryString;
			}
		}

		protected void _verifyForm_DataBound(object sender, EventArgs e)
		{
			if (_verifyForm.CurrentMode == FormViewMode.Edit)
			{
				var branchControl = (DropDownList)(_verifyForm).FindControl("_branch");
				var departmentControl = (DropDownList)(_verifyForm).FindControl("_department");
				var rankControl = (DropDownList)(_verifyForm).FindControl("_rank");
				var securityCheckBox = (CheckBox)(_verifyForm).FindControl("_securityCheckBox");
				var supervisorCheckBox = (CheckBox)(_verifyForm).FindControl("_supervisorCheckBox");
				var securitySignature = (TextBox)(_verifyForm).FindControl("_securitySignature");
				var supervisorSignature = (TextBox)(_verifyForm).FindControl("_supervisorSignature");
				if (securitySignature.Text.Length > 0)
				{
					securityCheckBox.Checked = true;
				}
				if (supervisorSignature.Text.Length > 0)
				{
					supervisorCheckBox.Checked = true;
				}

				foreach (string item in Setting.Rank)
				{
					if (rankControl.SelectedValue == item)
					{
						continue;
					}
					rankControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Department)
				{
					if (departmentControl.SelectedValue == item)
					{
						continue;
					}
					departmentControl.Items.Add(new ListItem(item, item));
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

		protected void _searchButton_Click(object sender, EventArgs e)
		{
			_verifyForm.Visible = true;
		}

		protected void _CheckBox_CheckedChanged(object sender, EventArgs e)
		{
			if (_verifyForm.CurrentMode == FormViewMode.Edit)
			{
				var securityCheckBox = (CheckBox)(_verifyForm).FindControl("_securityCheckBox");
				var supervisorCheckBox = (CheckBox)(_verifyForm).FindControl("_supervisorCheckBox");
				var securitySignature = (TextBox)(_verifyForm).FindControl("_securitySignature");
				var supervisorSignature = (TextBox)(_verifyForm).FindControl("_supervisorSignature");

				if (securityCheckBox.Checked)
				{
					securitySignature.Text = user.Edipi;
				}
				else
				{
					securitySignature.Text = "";
				}


				if (supervisorCheckBox.Checked)
				{
					supervisorSignature.Text = user.Edipi;
				}
				else
				{
					supervisorSignature.Text = "";
				}
			}
		}
	}
}