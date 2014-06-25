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
			string requestedAccount = Session["RequestedAccount"] as string;
            var userAccount = new AdAccount();
			 //Un-comment next line for testing a specific user
            //var userAccount = new AdAccount("564321354");

			if (!IsPostBack && requestedAccount != null)
			{
				bool accountExist;
				switch (requestedAccount)
				{
					case "NIPR" :
                        accountExist = userAccount.queryForest();
                        // Test Code next line
                        //accountExist = userAccount.queryOurDomain();
                        if (accountExist)
                        {
                            _niprName.Text = userAccount.NiprAccountName;
                            _niprResults.Visible = true;
                            _redirectMessage.Visible = true;
                            _formview.Visible = false;
                        }
						break;
					case "VPN"  :
						accountExist = userAccount.queryVpn();
						if (accountExist)
						{
							_vpnGroup.Text = userAccount.VpnGroupName;
							_vpnResults.Visible = true;
							_redirectMessage.Visible = true;
							_formview.Visible = false;
						}
						break;
					case "SIPR" :
					case "EP"   :
						accountExist = userAccount.queryOurDomain();
						if (!accountExist)
						{
							_epResults.Visible = true;
							_redirectMessage.Visible = true;
							_formview.Visible = false;
						}
						break;
				}
			}
			else if (!IsPostBack)
			{
                Server.Transfer("~/default.aspx");
			}
            if (IsPostBack)
            {
                var trainingDatePlaceHolder = (PlaceHolder)(_formview).FindControl("_trainingDatePlaceHolder");
                var trainingCheckBox = (CheckBox)(_formview).FindControl("_training");
                if (trainingCheckBox.Checked)
                {
                    trainingDatePlaceHolder.Visible = true;
                    var dateRangeValidator = (RangeValidator)(_formview).FindControl("_trainingDateRangeValidator");
                    string dynamicMinValue = DateTime.Today.AddYears(-1).ToShortDateString();
                    string dynamicMaxValue = DateTime.Today.ToShortDateString();
                    dateRangeValidator.MinimumValue = dynamicMinValue;
                    dateRangeValidator.MaximumValue = dynamicMaxValue;
                }
                else
                {
                    trainingDatePlaceHolder.Visible = false;
                }
            }
		}
		
		protected void _requestForm_DataBound(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Insert)
			{
				string requestedAccount = Session["RequestedAccount"] as string;
				var edipiControl = (TextBox)(_formview).FindControl("_edipi");
				var lNameControl = (TextBox)(_formview).FindControl("_lName");
				var fNameControl = (TextBox)(_formview).FindControl("_fName");
				var branchControl = (DropDownList)(_formview).FindControl("_branch");
				var orgUnitControl = (DropDownList)(_formview).FindControl("_orgUnit");
				var installationControl = (DropDownList)(_formview).FindControl("_installation");
				var macomControl = (DropDownList)(_formview).FindControl("_macom");
				var personaControl = (DropDownList)(_formview).FindControl("_persona");
				var rankControl = (DropDownList)(_formview).FindControl("_rank");
				var date = (TextBox)(_formview).FindControl("_date");
				var niprControl = (CheckBox)(_formview).FindControl("_niprAcct");
				var siprControl = (CheckBox)(_formview).FindControl("_siprAcct");
				var epControl = (CheckBox)(_formview).FindControl("_epAcct");
				var vpnControl = (CheckBox)(_formview).FindControl("_vpnAcct");
				var requestType = (TextBox)(_formview).FindControl("_requestType");
				var accountType = (TextBox)(_formview).FindControl("_accountType");
				var acctStatus = (TextBox)(_formview).FindControl("_acctStatus");
				var supSignedControl = (CheckBox)(_formview).FindControl("_supSigned");
				var secSignedControl = (CheckBox)(_formview).FindControl("_secSigned");
				var epUnits = (ListBox)(_formview).FindControl("_epUnitsList");
				var epPanel = (Panel)(_formview).FindControl("_epPanel");
				var niprPanel = (Panel)(_formview).FindControl("_niprPanel");

				edipiControl.Text = CacCard.Edipi;
				lNameControl.Text = CacCard.LastName;
				fNameControl.Text = CacCard.FirstName;
				accountType.Text = requestedAccount;
				acctStatus.Text = "Requested";
				date.Text = DateTime.Now.ToString();
				supSignedControl.Checked = false;
				secSignedControl.Checked = false;

				if (requestedAccount != null)
				{
					switch (requestedAccount)
					{
						case "NIPR":
							niprPanel.Visible = true;
							niprControl.Checked = true;
							requestType.Text = "Auto";
							break;
						case "SIPR":
							siprControl.Checked = true;
							requestType.Text = "Manual";
							break;
						case "EP":
							epPanel.Visible = true;
							epControl.Checked = true;
							requestType.Text = "Manual";
							break;
						case "VPN":
							vpnControl.Checked = true;
							requestType.Text = "Auto";
							break;
					}
				}

				foreach (string item in Setting.OrgUnit)
				{
					epUnits.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Persona)
				{
					personaControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Macom)
				{
					macomControl.Items.Add(new ListItem(item, item));
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

				if (CacCard.FirstName != null)
				{
					edipiControl.Enabled = false;
					lNameControl.Enabled = false;
					fNameControl.Enabled = false;
				}
			}
		}

		protected void _formview_ItemInserted(object sender, FormViewInsertedEventArgs e)
		{
			string successUrl = "success.aspx?search=" + CacCard.Edipi;
            Server.Transfer(successUrl, false);
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