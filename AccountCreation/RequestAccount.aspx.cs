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
				user = new CurrentUser("1463036744");
			}
			if (PreviousPage != null)
			{
				var niprRequest = PreviousPage.NiprRequest;
				var siprRequest = PreviousPage.SiprRequest;
				var vpnRequest = PreviousPage.VpnRequest;
				var epRequest = PreviousPage.EpRequest;

				if (niprRequest && user.AccountInfo.queryForNipr())
				{
					_niprName.Text = user.AccountInfo.NiprAccountName;
					_niprResults.Visible = true;
					_redirectMessage.Visible = true;
					_requestForm.Visible = false;
				}

				if (vpnRequest && user.AccountInfo.queryForVpn())
				{
					_vpnGroup.Text = user.AccountInfo.VpnGroupName;
					_vpnResults.Visible = true;
					_redirectMessage.Visible = true;
					_requestForm.Visible = false;
				}

				if (_requestForm.CurrentMode == FormViewMode.Insert)
				{
					var edipi = (TextBox)(_requestForm).FindControl("_edipi");
					var lName = (TextBox)(_requestForm).FindControl("_lName");
					var fName = (TextBox)(_requestForm).FindControl("_fName");
					var rankList = (DropDownList)(_requestForm).FindControl("_rank");

					edipi.Text = user.Edipi;
					lName.Text = user.LastName;
					fName.Text = user.FirstName;
				}
			}
			else
			{
				Response.Redirect("~/RequestType.aspx", true);
			}
		}
		

		protected void _requestForm_DataBound(object sender, EventArgs e)
		{
			if (_requestForm.CurrentMode == FormViewMode.Insert)
			{
				var rankList = (DropDownList)(_requestForm).FindControl("_rank");
				if (rankList != null)
				{
					foreach (string item in Vpn.Rank)
					{
						rankList.Items.Add(new ListItem(item, item));
					}
				}
				
			}
		}
	}
}