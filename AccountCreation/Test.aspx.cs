using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AccountCreation
{
	public partial class Test : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			_cacTest.Text = CacCard.LastName + " " + CacCard.FirstName + " " + CacCard.Edipi;
			var adAccount = new AdAccount();
			_currentUser.Text = adAccount.CurrentUser;
			adAccount.queryOurDomain();
			_niprAccount.Text = adAccount.NiprAccountName;
		}
	}
}