using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AccountCreation
{
	public partial class RequestAccount : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            string accountType = Session["AccountType"] as string;
            string requestType = Session["RequestType"] as string;
            var userAccount = new AdAccount();
             //Un-comment next line for testing a specific user
            //var userAccount = new AdAccount("123");

			if (!IsPostBack && accountType != null && requestType != null)
			{
                if (requestType == "Create")
                {
                    var dateRangeValidator = (RangeValidator)(_formview).FindControl("_trainingDateRangeValidator");
                    string dynamicMinValue = DateTime.Today.AddYears(-1).ToShortDateString();
                    string dynamicMaxValue = DateTime.Today.ToShortDateString();
                    dateRangeValidator.MinimumValue = dynamicMinValue;
                    dateRangeValidator.MaximumValue = dynamicMaxValue;
                    dateRangeValidator.Type = ValidationDataType.Date;

                    bool accountExist = false;
                    switch (accountType)
                    {
                        case "NIPR":
                            accountExist = userAccount.queryForest();
                            if (accountExist)
                            {
                                _niprName.Text = userAccount.NiprAccountName;
                                _createNiprFail.Visible = true;
                                _formview.Visible = false;
                            }
                            break;
                        case "VPN":
                            accountExist = userAccount.queryVpn();
                            if (accountExist)
                            {
                                _vpnGroup.Text = userAccount.VpnGroupName;
                                _createVpnFail.Visible = true;
                                _formview.Visible = false;
                                break;
                            }
                            accountExist = userAccount.queryOurDomain();
                            if (!accountExist)
                            {
                                _createSpecialAcctFail.Visible = true;
                                _formview.Visible = false;
                            }
                            break;
                        case "SIPR":
                        case "EP":
                            accountExist = userAccount.queryOurDomain();
                            if (!accountExist)
                            {
                                _createSpecialAcctFail.Visible = true;
                                _formview.Visible = false;
                            }
                            break;
                    }
                }
                else
                {
                    var dateRangeValidator = (RangeValidator)(_formview).FindControl("_deleteDateRangeValidator");
                    string dynamicMinValue = DateTime.Today.ToShortDateString();
                    string dynamicMaxValue = DateTime.Today.AddMonths(2).ToShortDateString();
                    dateRangeValidator.MinimumValue = dynamicMinValue;
                    dateRangeValidator.MaximumValue = dynamicMaxValue;
                    dateRangeValidator.Type = ValidationDataType.Date;

                    bool accountExist = false;
                    switch (accountType)
                    {
                        case "NIPR":
                            accountExist = userAccount.queryOurDomain();
                            if (!accountExist)
                            {
                                _deleteNiprFail.Visible = true;
                                _formview.Visible = false;
                            }
                            break;
                        case "VPN":
                            accountExist = userAccount.queryVpn();
                            if (!accountExist)
                            {
                                _deleteVpnFail.Visible = true;
                                _formview.Visible = false;
                            }
                            break;
                    }
                }
			}
            else if (!IsPostBack && accountType == null)
			{
                Server.Transfer("~/default.aspx");
			}
		}
		
		protected void _requestForm_DataBound(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Insert)
			{
                string accountType = Session["AccountType"] as string;
                string requestType = Session["RequestType"] as string;
                var edipiControl = (TextBox)(_formview).FindControl("_edipi");
				var lNameControl = (TextBox)(_formview).FindControl("_lName");
                var fNameControl = (TextBox)(_formview).FindControl("_fName");
                var mNameControl = (TextBox)(_formview).FindControl("_middleInitial");
                var branchControl = (DropDownList)(_formview).FindControl("_branch");
				var orgUnitControl = (DropDownList)(_formview).FindControl("_orgUnit");
				var installationControl = (DropDownList)(_formview).FindControl("_installation");
				var personaControl = (DropDownList)(_formview).FindControl("_persona");
				var rankControl = (DropDownList)(_formview).FindControl("_rank");
				var dateControl = (TextBox)(_formview).FindControl("_date");
				var niprControl = (CheckBox)(_formview).FindControl("_niprAcct");
				var siprControl = (CheckBox)(_formview).FindControl("_siprAcct");
				var epControl = (CheckBox)(_formview).FindControl("_epAcct");
				var vpnControl = (CheckBox)(_formview).FindControl("_vpnAcct");
				var requestTypeControl = (TextBox)(_formview).FindControl("_requestType");
				var accountTypeControl = (TextBox)(_formview).FindControl("_accountType");
				var acctStatusControl = (TextBox)(_formview).FindControl("_acctStatus");
				var supSignedControl = (CheckBox)(_formview).FindControl("_supSigned");
				var secSignedControl = (CheckBox)(_formview).FindControl("_secSigned");
				var epUnitsControl = (ListBox)(_formview).FindControl("_epUnitsList");
				var epPanelControl = (Panel)(_formview).FindControl("_epPanel");
                var trainingPanelControl = (Panel)(_formview).FindControl("_trainingPanel");
                var deleteRequestPanelControl = (Panel)(_formview).FindControl("_deleteRequestPanel");

				acctStatusControl.Text = "Requested";
				dateControl.Text = DateTime.Now.ToString();
				supSignedControl.Checked = false;
				secSignedControl.Checked = false;
                edipiControl.Text = CacCard.Edipi;
                lNameControl.Text = CacCard.LastName;
                fNameControl.Text = CacCard.FirstName;
                mNameControl.Text = CacCard.MiddleInitial;

                if (CacCard.FirstName != null)
                {
                    edipiControl.Enabled = false;
                    lNameControl.Enabled = false;
                    fNameControl.Enabled = false;
                    mNameControl.Enabled = false;
                }

				if (accountType != null && requestType != null)
				{
                    accountTypeControl.Text = accountType;

                    if (requestType == "Create")
                    {
                        deleteRequestPanelControl.Visible = false;
                        trainingPanelControl.Visible = true;
                    }
                    else
                    {
                        deleteRequestPanelControl.Visible = true;
                        trainingPanelControl.Visible = false;
                    }

					switch (accountType)
					{
						case "NIPR":
                            if (requestType == "Create")
                            {
                                requestTypeControl.Text = "Auto Create";
                            }
                            else
                            {
                                requestTypeControl.Text = "Manual Delete";
                            }
							niprControl.Checked = true;
							break;
						case "SIPR":
                            if (requestType == "Create")
                            {
                                requestTypeControl.Text = "Manual Create";
                            }
                            else
                            {
                                requestTypeControl.Text = "Manual Delete";
                            }
							siprControl.Checked = true;
							break;
						case "EP":
                            if (requestType == "Create")
                            {
                                epPanelControl.Visible = true;
                                requestTypeControl.Text = "Manual Create";
                            }
                            else
                            {
                                requestTypeControl.Text = "Manual Delete";
                            }
							epControl.Checked = true;
							break;
						case "VPN":
                            if (requestType == "Create")
                            {
                                // TODO: check if vpn is auto or manual
                                requestTypeControl.Text = "Manual Create";
                            }
                            else
                            {
                                requestTypeControl.Text = "Manual Delete";
                            }
							vpnControl.Checked = true;
							break;
					}
				}

				foreach (string item in Setting.OrgUnit)
				{
					epUnitsControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Persona)
				{
					personaControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Installation)
				{
					installationControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Rank)
				{
					rankControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.OrgUnit)
				{
					orgUnitControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Branch)
				{
					branchControl.Items.Add(new ListItem(item, item));
				}
			}
		}

		protected void _formview_ItemInserted(object sender, FormViewInsertedEventArgs e)
		{
            Session["FormSubmitted"] = true;
            Server.Transfer("success.aspx");
		}

		protected void _formview_ItemInserting(object sender, FormViewInsertEventArgs e)
		{
			if (!Page.IsValid)
			{
				e.Cancel = true;
			}
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