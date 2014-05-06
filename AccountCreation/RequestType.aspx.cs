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
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Request.ClientCertificate.IsPresent && !IsPostBack)
			{
				var cac = Request.ClientCertificate;
				var user = new CurrentUser(cac);
				Session["edipi"] = user.Edipi;
			}
		}

		protected void _submitBtn_Click(object sender, EventArgs e)
		{
			if (_niprAcct.Checked)
			{
				var user = new CurrentUser((string)Session["edipi"]);
				bool hasNipr = user.AccountInfo.queryForNipr();
				if (hasNipr)
				{
				}
			}

			if (_vpnAcct.Checked)
			{
				var user = new CurrentUser((string)Session["edipi"]);
				bool hasVpn = user.AccountInfo.queryForVpn();
			}
		}
	}
}