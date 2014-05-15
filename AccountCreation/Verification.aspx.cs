using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AccountCreation
{
	public partial class Verification : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void _rank_DataBound(object sender, EventArgs e)
		{
			if (_verifyForm.CurrentMode == FormViewMode.Edit)
			{
				var rankControl = (DropDownList)(_verifyForm).FindControl("_rank");

				foreach (string item in Setting.Rank)
				{
					if (rankControl.SelectedValue == item)
					{
						continue;
					}
					rankControl.Items.Add(new ListItem(item, item));
				}
			}
		}

	}
}