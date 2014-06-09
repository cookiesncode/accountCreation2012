using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AccountCreation
{
	public partial class SA_Admin : System.Web.UI.Page
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
				var adInfo = (PlaceHolder)(_formview).FindControl("_adInfo");
				var requestType = (TextBox)(_formview).FindControl("_requestType");
				var saSignature = (TextBox)(_formview).FindControl("_saSignature");
				var saCheckBox = (CheckBox)(_formview).FindControl("_saCheckBox");
				Button updateButton = null;

				if (requestType.Text == "Manual")
				{
					adInfo.Visible = true;
				}

				if (saSignature.Text.Length > 0)
				{
					saCheckBox.Enabled = false;
					saCheckBox.Checked = true;
				}

				if (saCheckBox.Checked)
				{
					updateButton = (Button)(_formview).FindControl("_updateButton");
					updateButton.Visible = false;
				}
			}
		}

		protected void _searchButton_Click(object sender, EventArgs e)
		{
			_filterPanel.Visible = true;
			_gridview.Visible = true;
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

		protected void _sa_CheckBox_CheckedChanged(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Edit)
			{
				var saCheckBox = (CheckBox)(_formview).FindControl("_saCheckBox");
				var saName = (TextBox)(_formview).FindControl("_saName");
				var saSignature = (TextBox)(_formview).FindControl("_saSignature");
				var acctStatus = (TextBox)(_formview).FindControl("_acctStatus");
				var dateCreated = (TextBox)(_formview).FindControl("_dateCreated");

				if (saCheckBox.Checked)
				{
					saName.Text = user.FirstName + " " + user.LastName;
					saSignature.Text = user.Edipi;
					acctStatus.Text = "Created";
					dateCreated.Text = DateTime.Now.ToString();
				}
				else
				{
					saName.Text = "";
					saSignature.Text = "";
					acctStatus.Text = "";
				}
			}
		}
	}
}