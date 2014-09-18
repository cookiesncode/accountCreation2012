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
            _cacMiddleInitial.Text = CacCard.MiddleInitial;
            var existingRequest = Record.QueryRecords("1398696464", "SIPR", "Manual Create");
            if (!IsPostBack)
            {
                foreach (string item in Setting.OrgUnit)
				{
                    _units.Items.Add(new ListItem(item, item));
				}
				
            }
		}
	}
}