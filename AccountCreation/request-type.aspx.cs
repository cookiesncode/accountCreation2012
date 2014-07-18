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
                Session["RequestType"] = _requestType.SelectedValue;
                Session["AccountType"] = _accountType.SelectedValue;
                Server.Transfer("~/request-account.aspx");
			}
		}
	}
}