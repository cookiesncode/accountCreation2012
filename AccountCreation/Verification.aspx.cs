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
			if (!IsPostBack)
			{
				_verifyForm.Visible = false;
			}
		}

		protected void _rank_DataBound(object sender, EventArgs e)
		{
			if (_verifyForm.CurrentMode == FormViewMode.Edit)
			{
				var branchControl = (DropDownList)(_verifyForm).FindControl("_branch");
				var departmentControl = (DropDownList)(_verifyForm).FindControl("_department");
				var rankControl = (DropDownList)(_verifyForm).FindControl("_rank");
				
				foreach (string item in Setting.Rank)
				{
					if (rankControl.SelectedValue == item)
					{
						continue;
					}
					rankControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Department)
				{
					if (departmentControl.SelectedValue == item)
					{
						continue;
					}
					departmentControl.Items.Add(new ListItem(item, item));
				}
				foreach (string item in Setting.Branch)
				{
					if (branchControl.SelectedValue == item)
					{
						continue;
					}
					branchControl.Items.Add(new ListItem(item, item));
				}
			}
		}

		protected void _searchButton_Click(object sender, EventArgs e)
		{
			_verifyForm.Visible = true;
		}

	}
}