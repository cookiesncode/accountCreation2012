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
				var cac = Request.ClientCertificate;
				var user = new CurrentUser(cac);
				Session["edipi"] = user.Edipi;

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