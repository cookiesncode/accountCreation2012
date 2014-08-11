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
		protected void Page_Load(object sender, EventArgs e)
		{
            if (!Page.User.IsInRole("CARSON NEC SSD SMB SA SG"))
            {
                Response.StatusCode = 403;
                Response.SuppressContent = true;
            }

			var seachQueryString = Request.QueryString["search"];
			if (!IsPostBack && seachQueryString != null)
			{
				_gridview.Visible = true;
				_searchBox.Text = seachQueryString;
			}
		}

		protected void _formview_DataBound(object sender, EventArgs e)
		{
            // TODO: Change formview if not using edit mode
			if (_formview.CurrentMode == FormViewMode.Edit)
			{
				var adContainer = (PlaceHolder)(_formview).FindControl("_adInfo");
				var epPanel = (Panel)(_formview).FindControl("_epPanel");
				var accountType = (TextBox)(_formview).FindControl("_accountType");
				var saSignature = (TextBox)(_formview).FindControl("_saSignature");
				var saCheckBox = (CheckBox)(_formview).FindControl("_saCheckBox");
                var deleteDatePanelControl = (Panel)(_formview).FindControl("_deleteRequestPanel");
                var requestTypeControl = (TextBox)(_formview).FindControl("_requestType");

				Button updateButton = null;

                if (requestTypeControl.Text == "Manual Delete" || requestTypeControl.Text == "Auto Delete")
                {
                    deleteDatePanelControl.Visible = true;
                }
				if (accountType.Text != "NIPR")
				{
					adContainer.Visible = true;
				}

				if (accountType.Text == "EP")
				{
					epPanel.Visible = true;
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

		protected void _sa_CheckBox_CheckedChanged(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Edit)
			{
				var saCheckBox = (CheckBox)(_formview).FindControl("_saCheckBox");
				var saName = (TextBox)(_formview).FindControl("_saName");
				var saSignature = (TextBox)(_formview).FindControl("_saSignature");

				if (saCheckBox.Checked)
				{
					saName.Text = CacCard.FirstName + " " + CacCard.LastName;
					saSignature.Text = CacCard.Edipi;
				}
				else
				{
					saName.Text = "";
					saSignature.Text = "";
				}
			}
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
                var requestStatus = (DropDownList)(_formview).FindControl("_editRequestStatus");
                var completedDate = (TextBox)(_formview).FindControl("_completedDate");
                var modifiedDate = (TextBox)(_formview).FindControl("_modifiedDate");
                if (requestStatus.SelectedValue == "Completed" || requestStatus.SelectedValue == "Denied")
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
	}
}