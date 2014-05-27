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
				_gridview.Visible = true;
				_searchBox.Text = seachQueryString;
			}
		}

		protected void _formview_DataBound(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Edit)
			{
				var branchControl = (DropDownList)(_formview).FindControl("_branch");
				var departmentControl = (DropDownList)(_formview).FindControl("_department");
				var rankControl = (DropDownList)(_formview).FindControl("_rank");
				var supervisorSignature = (TextBox)(_formview).FindControl("_supervisorSignature");
				var supervisorCheckBox = (CheckBox)(_formview).FindControl("_supervisorCheckBox");
				Button updateButton = null;
				CheckBox securityCheckBox = null;
				TextBox securitySignature = null;
				PlaceHolder securityBoxPlaceholder = (PlaceHolder)(_formview).FindControl("_securityBoxPlaceholder");

				if (supervisorSignature.Text.Length > 0  && securitySignature == null)
				{
					supervisorCheckBox.Enabled = false;
					supervisorCheckBox.Checked = true;
					securityBoxPlaceholder.Visible = true;
					securitySignature = (TextBox)(_formview).FindControl("_securitySignature");
					securityCheckBox = (CheckBox)(_formview).FindControl("_securityCheckBox");
				}

				if (securitySignature != null && securitySignature.Text.Length > 0)
				{
					securityCheckBox.Enabled = false;
					securityCheckBox.Checked = true;
				}

				if (supervisorCheckBox.Checked && securityCheckBox.Checked)
				{
					updateButton = (Button)(_formview).FindControl("_updateButton");
					updateButton.Visible = false;
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
			_gridview.Visible = true;
		}

		protected void _supervisor_CheckBox_CheckedChanged(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Edit)
			{
				var supervisorCheckBox = (CheckBox)(_formview).FindControl("_supervisorCheckBox");
				var supervisorSignature = (TextBox)(_formview).FindControl("_supervisorSignature");
				var supSignedDate = (TextBox)(_formview).FindControl("_supSignedDate");
				var supSigned = (CheckBox)(_formview).FindControl("_supSigned");
				var acctStatus = (TextBox)(_formview).FindControl("_acctStatus");

				if (supervisorCheckBox.Checked)
				{
					supervisorSignature.Text = user.Edipi;
					supSignedDate.Text = DateTime.Now.ToString();
					supSigned.Checked = true;
					acctStatus.Text = "Supervisor Approved";
				}
				else
				{
					supervisorSignature.Text = "";
					supSignedDate.Text = "";
					supSigned.Checked = false;
					acctStatus.Text = "";
				}
			}
		}

		protected void _security_CheckBox_CheckedChanged(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Edit)
			{
				var securityCheckBox = (CheckBox)(_formview).FindControl("_securityCheckBox");
				var securitySignature = (TextBox)(_formview).FindControl("_securitySignature");
				var secSignedDate = (TextBox)(_formview).FindControl("_secSignedDate");
				var secSigned = (CheckBox)(_formview).FindControl("_secSigned");
				var acctStatus = (TextBox)(_formview).FindControl("_acctStatus");

				if (securityCheckBox.Checked)
				{
					securitySignature.Text = user.Edipi;
					secSignedDate.Text = DateTime.Now.ToString();
					secSigned.Checked = true;
					acctStatus.Text = "Ready";
				}
				else
				{
					securitySignature.Text = "";
					secSignedDate.Text = "";
					secSigned.Checked = false;
					acctStatus.Text = "";
				}
			}
		}

		protected void _gridview_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (IsPostBack)
			{
				_formview.Visible = true;
			}
			else
			{
				_formview.Visible = false;
			}
		}

		protected void _cancelButton_Click(object sender, EventArgs e)
		{
			_formview.Visible = false;
			_formview.DataBind();
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
	}
}