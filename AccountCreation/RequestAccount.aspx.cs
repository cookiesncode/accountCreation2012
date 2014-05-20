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
					_formview.Visible = false;
				}

				if (PreviousPage.VpnRequest && user.AccountInfo.queryForVpn())
				{
					_vpnGroup.Text = user.AccountInfo.VpnGroupName;
					_vpnResults.Visible = true;
					_redirectMessage.Visible = true;
					_formview.Visible = false;
				}
			}
			else if (!IsPostBack)
			{
				Response.Redirect("~/RequestType.aspx", true);
			}
		}
		
		protected void _requestForm_DataBound(object sender, EventArgs e)
		{
			if (_formview.CurrentMode == FormViewMode.Insert)
			{
				var branchControl = (DropDownList)(_formview).FindControl("_branch");
				var departmentControl = (DropDownList)(_formview).FindControl("_department");
				//var installationControl = (DropDownList)(_formview).FindControl("_installation");
				//var orgControl = (DropDownList)(_formview).FindControl("_org");
				var rankControl = (DropDownList)(_formview).FindControl("_rank");

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

				var edipiControl = (TextBox)(_formview).FindControl("_edipi");
				var lNameControl = (TextBox)(_formview).FindControl("_lName");
				var fNameControl = (TextBox)(_formview).FindControl("_fName");
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

		protected void _formview_ItemInserted(object sender, FormViewInsertedEventArgs e)
		{
			string successUrl = string.Format("Success.aspx?search={0}", user.Edipi);
			Response.Redirect(successUrl);
		}

		protected void _formview_ItemInserting(object sender, FormViewInsertEventArgs e)
		{
			if (Page.IsValid)
			{
				_formview.InsertItem(true);
			}
		}
	}
}