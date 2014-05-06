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
			CurrentUser user;
			var cac = Request.ClientCertificate;
			if (Request.ClientCertificate.IsPresent)
			{
				user = new CurrentUser(cac);
			}
			else
			{
				//testing purposes only; Note!: this method does not output any info from the CAC card.
				user = new CurrentUser("1265020972");
			}
			if (PreviousPage != null)
			{
				var niprRequest = PreviousPage.NiprRequest;
				var siprRequest = PreviousPage.SiprRequest;
				var vpnRequest = PreviousPage.VpnRequest;
				var epRequest = PreviousPage.EpRequest;
				
				if (niprRequest)
				{
					if (user.AccountInfo.queryForNipr())
					{
						_niprName.Text = user.AccountInfo.NiprAccountName;
						_niprResults.Visible = true;
						_requestForm.Visible = false;
					}
				}

				if (vpnRequest)
				{
					if (user.AccountInfo.queryForVpn())
					{
						_vpnGroup.Text = user.AccountInfo.VpnGroupName;
						_vpnResults.Visible = true;
						_requestForm.Visible = false;
					}
				}

				if (_requestForm.CurrentMode == FormViewMode.Insert)
				{
					var edipi = (TextBox)(_requestForm).FindControl("_edipi");
					var lName = (TextBox)(_requestForm).FindControl("_lName");
					var fName = (TextBox)(_requestForm).FindControl("_fName");

					edipi.Text = user.Edipi;
					lName.Text = user.LastName;
					fName.Text = user.FirstName;
				}
			}
		}
	}
}