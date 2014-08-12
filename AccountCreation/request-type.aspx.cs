using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AccountCreation
{
	public partial class RequestType : System.Web.UI.Page
	{
		protected void _submitBtn_Click(object sender, EventArgs e)
		{
			if (Page.IsValid)
			{
                var accountType = _accountType.SelectedValue;
                var requestType = _requestType.SelectedValue;
                string computedRequestType = null;
				switch (accountType)
				{
					case "NIPR":
                        if (requestType == "Create")
                        {
                            computedRequestType = "Auto Create";
                        }
                        else
                        {
                            computedRequestType = "Manual Delete";
                        }
						break;
					case "SIPR":
                    case "EP":
                    case "VPN":
                    case "SA":
                        if (requestType == "Create")
                        {
                            computedRequestType = "Manual Create";
                        }
                        else
                        {
                            computedRequestType = "Manual Delete";
                        }
						break;
				}
                // Testing variable:
                var existingRequest = Record.QueryRecords("1398696464", accountType, computedRequestType);
                // Production variable:
                //var existingRequest = Record.QueryRecords(CacCard.Edipi, accountType, computedRequestType);

                if (existingRequest != null)
                {
                    _requestWarning.Visible = true;
                    _reviewLink.NavigateUrl = "~/verification.aspx?search=" + CacCard.Edipi;
                }
                else
                {
                    Session["RequestType"] = _requestType.SelectedValue;
                    Session["AccountType"] = _accountType.SelectedValue;
                    Server.Transfer("~/request-account.aspx");
                }
			}
		}
	}
}