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
            var currentUser = userAccount.CurrentUser;
			if (!IsPostBack && accountType != null && requestType != null && currentUser != null)
			{
                if (requestType == "Create")
                {
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
                        case "SA":
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
				var requestStatusControl = (TextBox)(_formview).FindControl("_requestStatus");
                requestStatusControl.Text = "Requested";

                var supSignedControl = (CheckBox)(_formview).FindControl("_supSigned");
                supSignedControl.Checked = false;

                var secSignedControl = (CheckBox)(_formview).FindControl("_secSigned");
                secSignedControl.Checked = false;

                var iaSignedControl = (CheckBox)(_formview).FindControl("_iaSigned");
                iaSignedControl.Checked = false;

                var dsdSignedControl = (CheckBox)(_formview).FindControl("_dsdSigned");
                dsdSignedControl.Checked = false;

                var saSignedControl = (CheckBox)(_formview).FindControl("_saSigned");
                saSignedControl.Checked = false;

                var dateControl = (TextBox)(_formview).FindControl("_date");          
				dateControl.Text = DateTime.Now.ToString();

                if (CacCard.FirstName != null)
                {
                    var edipiControl = (TextBox)(_formview).FindControl("_edipi");
                    edipiControl.Text = CacCard.Edipi;
                    edipiControl.Enabled = false;

                    var lNameControl = (TextBox)(_formview).FindControl("_lName");
                    lNameControl.Text = CacCard.LastName;
                    lNameControl.Enabled = false;

                    var fNameControl = (TextBox)(_formview).FindControl("_fName");
                    fNameControl.Text = CacCard.FirstName;
                    fNameControl.Enabled = false;
                   
                    var mNameControl = (TextBox)(_formview).FindControl("_middleInitial");
                    mNameControl.Text = CacCard.MiddleInitial;
                    mNameControl.Enabled = false;
                }
                
                string accountType = Session["AccountType"] as string;
                string requestType = Session["RequestType"] as string;

				if (accountType != null && requestType != null)
				{
                    var accountTypeControl = (TextBox)(_formview).FindControl("_accountType");
                    accountTypeControl.Text = accountType;

                    var deleteRequestPanelControl = (Panel)(_formview).FindControl("_deleteRequestPanel");
                    var trainingPanelControl = (Panel)(_formview).FindControl("_trainingPanel");

                    if (requestType == "Create")
                    {
                        deleteRequestPanelControl.Visible = false;
                        trainingPanelControl.Visible = true;

                        var trainingDateRangeValidator = (RangeValidator)(_formview).FindControl("_trainingDateRangeValidator");
                        trainingDateRangeValidator.MinimumValue = DateTime.Today.AddYears(-1).ToShortDateString();
                        trainingDateRangeValidator.MaximumValue = DateTime.Today.ToShortDateString();
                        trainingDateRangeValidator.Type = ValidationDataType.Date;
                    }
                    else
                    {
                        deleteRequestPanelControl.Visible = true;
                        var deleteDateRangeValidator = (RangeValidator)(_formview).FindControl("_deleteDateRangeValidator");
                        deleteDateRangeValidator.MinimumValue = DateTime.Today.ToShortDateString();
                        deleteDateRangeValidator.MaximumValue = DateTime.Today.AddMonths(2).ToShortDateString();
                        deleteDateRangeValidator.Type = ValidationDataType.Date;
                        trainingPanelControl.Visible = false;
                    }

                    var saPanelControl = (Panel)(_formview).FindControl("_saPanel");
                    var siprSection = (Panel)(_formview).FindControl("_siprSection");
                    var justificationPanelControl = (Panel)(_formview).FindControl("_justificationPanel");
                    var epControl = (CheckBox)(_formview).FindControl("_epAcct");
                    var saControl = (CheckBox)(_formview).FindControl("_saAcct");
                    var niprControl = (CheckBox)(_formview).FindControl("_niprAcct");
                    var siprControl = (CheckBox)(_formview).FindControl("_siprAcct");
                    var vpnControl = (CheckBox)(_formview).FindControl("_vpnAcct");
                    var requestTypeControl = (TextBox)(_formview).FindControl("_requestType");
                   
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
                                siprSection.Visible = true;
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
                                justificationPanelControl.Visible = true;
                                requestTypeControl.Text = "Manual Create";
                            }
                            else
                            {
                                requestTypeControl.Text = "Manual Delete";
                            }
							epControl.Checked = true;
							break;
                        case "SA":
                            if (requestType == "Create")
                            {
                                saPanelControl.Visible = true;
                                justificationPanelControl.Visible = true;
                                requestTypeControl.Text = "Manual Create";
                            }
                            else
                            {
                                requestTypeControl.Text = "Manual Delete";
                            }
                            saControl.Checked = true;
                            break;
						case "VPN":
                            if (requestType == "Create")
                            {
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

                var unitListControl = (ListBox)(_formview).FindControl("_unitList");
                var branchControl = (DropDownList)(_formview).FindControl("_branch");
                var orgUnitControl = (DropDownList)(_formview).FindControl("_orgUnit");
                var installationControl = (DropDownList)(_formview).FindControl("_installation");
                var personaControl = (DropDownList)(_formview).FindControl("_persona");
                var rankControl = (DropDownList)(_formview).FindControl("_rank");

				foreach (string item in Setting.OrgUnit)
				{
					unitListControl.Items.Add(new ListItem(item, item));
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
            var accountType = (TextBox)(_formview).FindControl("_accountType");
            var userEmail = (TextBox)(_formview).FindControl("_email");
            var userMessage = "Please hold on to this email until your request has been completed. You may click on the link below to check on the status of your request. Please remember that your request will not be reviewed until you have all of the signatures required from your approval staff.";
            var userName = CacCard.FirstName + " " + CacCard.LastName;
            var userLink = "https://nec.carson.army.mil/accounts/verification.aspx?search=" + CacCard.Edipi;
            Email.SendEmail(userEmail.Text, userMessage, userName, userLink, accountType.Text, true);
            
            Server.Transfer("success.aspx");
		}

		protected void _formview_ItemInserting(object sender, FormViewInsertEventArgs e)
		{
			if (!Page.IsValid)
			{
				e.Cancel = true;
			}
		}
	}
}