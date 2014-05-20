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
			string searchValue;
			if (Request.QueryString["search"] != null)
			{
				searchValue = Request.QueryString["search"];
				string verifyPageUrl = "https://nec.carson.army.mil/test-account-creation/Verification.aspx?search=" + searchValue;
				_verifyUrl.Text = verifyPageUrl;
				_verifyUrl.NavigateUrl = verifyPageUrl;
			}
		}
	}
}