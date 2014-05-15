using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AccountCreation
{
	public partial class Success : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			string edipi;
			if (Request.QueryString["edipi"] != null)
			{
				edipi = Request.QueryString["edipi"];
				string verifyPageUrl = "Verification.aspx?edipi=" + edipi;
				_verifyUrl.Text = verifyPageUrl;
				_verifyUrl.NavigateUrl = verifyPageUrl;
			}
		}
	}
}