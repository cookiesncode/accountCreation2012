using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AccountCreation
{
	public partial class MainLayout : System.Web.UI.MasterPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            if (Page.User.IsInRole("CARSON NEC SSD SMB SA SG") || Page.User.IsInRole("CARSON NEC IA Account Review"))
			{
				_saLink.Visible = true;
			}
		}
	}
}