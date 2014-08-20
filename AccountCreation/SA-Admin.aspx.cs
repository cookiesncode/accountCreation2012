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
 
                var saSignatureControl = (TextBox)(_formview).FindControl("_saSignature");
                // JANK There is no boolean for the SA signature in the DB, so this step is required.
                if (saSignatureControl.Text.Length > 0)
                {
                    var saCheckBoxControl = (CheckBox)(_formview).FindControl("_saCheckBox");
                    saCheckBoxControl.Enabled = false;
                    saCheckBoxControl.Checked = true;
                }
                // I check for "EP" as well since SA and EP used to be combined into one field, which was EP. It will be safe to delete this check once the data is archived for year 2014.
                if (requestTypeControl.Text.Contains("Create") && (accountTypeControl.Text == "SA" || accountTypeControl.Text == "EP"))
                {
                    var justificationPanelControl = (Panel)(_formview).FindControl("_justificationPanel");
                    justificationPanelControl.Visible = true;
                    // TODO: UPDATE control panel name to say SA. need to fix aspx file as well.
                    var saPanelControl = (Panel)(_formview).FindControl("_saPanel");
                    saPanelControl.Visible = true;

                    if (saSignatureControl.Text.Length > 0)
                    {
                        var iASection = (PlaceHolder)(_formview).FindControl("_iABox");
                        iASection.Visible = true;
                    }

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

        protected void _iA_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (_formview.CurrentMode == FormViewMode.Edit)
            {
                var iACheckBoxControl = (CheckBox)(_formview).FindControl("_iACheckBox");
                var iASignatureControl = (TextBox)(_formview).FindControl("_iASignature");
                var iADateSignedControl = (TextBox)(_formview).FindControl("_iADateSigned");

                if (iACheckBoxControl.Checked)
                {
                    iASignatureControl.Text = CacCard.Edipi;
                    iADateSignedControl.Text = DateTime.Now.ToString();
                }
                else
                {
                    iASignatureControl.Text = "";
                    iADateSignedControl.Text = "";
                }
            }
        }
	}
}