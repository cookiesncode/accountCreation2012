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
		private CurrentUser user;

		protected void Page_Load(object sender, EventArgs e)
		{
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
				if (PreviousPage.NiprRequest && user.AccountInfo.queryForNipr())
				{
					_niprName.Text = user.AccountInfo.NiprAccountName;
					_niprResults.Visible = true;
					_redirectMessage.Visible = true;
					_requestForm.Visible = false;
				}

				if (PreviousPage.VpnRequest && user.AccountInfo.queryForVpn())
				{
					_vpnGroup.Text = user.AccountInfo.VpnGroupName;
					_vpnResults.Visible = true;
					_redirectMessage.Visible = true;
					_requestForm.Visible = false;
				}
			}
			else if (!IsPostBack)
			{
				Response.Redirect("~/RequestType.aspx", true);
			}
		}
		
		protected void _requestForm_DataBound(object sender, EventArgs e)
		{
			if (_requestForm.CurrentMode == FormViewMode.Insert)
			{
				var branchControl = (DropDownList)(_requestForm).FindControl("_branch");
				var departmentControl = (DropDownList)(_requestForm).FindControl("_department");
				//var installationControl = (DropDownList)(_requestForm).FindControl("_installation");
				//var orgControl = (DropDownList)(_requestForm).FindControl("_org");
				var rankControl = (DropDownList)(_requestForm).FindControl("_rank");

				foreach (string item in Setting.Rank)
				{
					rankControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Department)
				{
					departmentControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Branch)
				{
					branchControl.Items.Add(new ListItem(item, item));
				}

				var edipiControl = (TextBox)(_requestForm).FindControl("_edipi");
				var lNameControl = (TextBox)(_requestForm).FindControl("_lName");
				var fNameControl = (TextBox)(_requestForm).FindControl("_fName");
				edipiControl.Text = user.Edipi;
				lNameControl.Text = user.LastName;
				fNameControl.Text = user.FirstName;

				if (user.FirstName != null)
				{
					edipiControl.Enabled = false;
					lNameControl.Enabled = false;
					fNameControl.Enabled = false;
				}
			}
		}

		protected void _submitBtn_Click(object sender, EventArgs e)
		{

			string successUrl = string.Format("Success.aspx?search={0}", user.Edipi);
			Response.Redirect(successUrl);
		}
	}
}