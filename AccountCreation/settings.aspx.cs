using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Diagnostics;

namespace AccountCreation
{
    public partial class settings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        // This if statement is a conditional compilation statement. The next piece of code will only compile for the release or staging version.
        # if RELEASE || STAGING
            if (!Page.User.IsInRole("CARSON NEC SSD SMB SA SG"))
            {
                Response.StatusCode = 403;
                Response.SuppressContent = true;
            }            
        # endif
        }

        protected void _listView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            var activeControl = (Control)sender;
            Panel activeTab = null;
            HtmlGenericControl activeLink = null;
            switch (activeControl.ID)
            {
                case "_unitListView":
                    activeTab = _unitTab;
                    activeLink = _unitListItem;
                    break;
                case "_rankListView":
                    activeTab = _rankTab;
                    activeLink = _rankListItem;
                    break;
                case "_personaListView":
                    activeTab = _personaTab;
                    activeLink = _personaListItem;
                    break;
                case "_branchListView":
                    activeTab = _branchTab;
                    activeLink = _branchListItem;
                    break;
                case "_installationListView":
                    activeTab = _installationTab;
                    activeLink = _installationListItem;
                    break;
                case "_officeListView":
                    activeTab = _officeTab;
                    activeLink = _officeListItem;
                    break;
            }
            var normalState = "tab-pane fade";
            var activeState = "tab-pane fade in active";

            _unitTab.CssClass = normalState;
            _rankTab.CssClass = normalState;
            _personaTab.CssClass = normalState;
            _branchTab.CssClass = normalState;
            _installationTab.CssClass = normalState;
            _officeTab.CssClass = normalState;

            _unitListItem.Attributes.Remove("class");
            _rankListItem.Attributes.Remove("class");
            _personaListItem.Attributes.Remove("class");
            _branchListItem.Attributes.Remove("class");
            _installationListItem.Attributes.Remove("class");
            _officeListItem.Attributes.Remove("class");

            activeTab.CssClass = activeState;
            activeLink.Attributes.Add("class", "active");

        }
    }
}