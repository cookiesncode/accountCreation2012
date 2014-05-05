using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Text;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.DirectoryServices.ActiveDirectory;

namespace AccountCreation
{
	public partial class RequestAccount : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Request.ClientCertificate.IsPresent && !IsPostBack)
			{
				var user = new CurrentUser();
				Session["edipi"] = user.Edipi;
				if (uiAccountRequestForm.CurrentMode == FormViewMode.Insert)
				{
					var uiEdipi = (TextBox)(uiAccountRequestForm).FindControl("uiEdipi");
					var uiLname = (TextBox)(uiAccountRequestForm).FindControl("uiLname");
					var uiFname = (TextBox)(uiAccountRequestForm).FindControl("uiFname");

					uiEdipi.Text = user.Edipi;
					uiLname.Text = user.LastName;
					uiFname.Text = user.FirstName;
				}
			}
		}

		protected void uiAcctCheckBtn_Click(object sender, EventArgs e)
		{
			if (uiNiprAcct.Checked)
			{
				var user = new CurrentUser();
				bool hasNipr = user.AccountInfo.queryForNipr();
				if (hasNipr)
				{
					uiAdResultsOutput.Text = user.AccountInfo.LogonName;
					uiAdCheckContainer.Visible = false;
					uiAdResultsContainer.Visible = true;
				}
			}

			if (uiVpnAcct.Checked)
			{
				var user = new CurrentUser("1042491973");
				bool hasVpn = user.AccountInfo.queryForVpn();
			}
		}

	}
}