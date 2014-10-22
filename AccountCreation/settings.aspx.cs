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
            if (IsPostBack)
            {
            }
        }

        protected void _listView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            var control = sender as Control;
            Panel activeTab = null;
            HtmlGenericControl activeLink = null;
            switch (control.ID)
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
            }
            var normalState = "tab-pane fade";
            var activeState = "tab-pane fade in active";

            _unitTab.CssClass = normalState;
            _rankTab.CssClass = normalState;
            _personaTab.CssClass = normalState;
            _branchTab.CssClass = normalState;
            _installationTab.CssClass = normalState;

            _unitListItem.Attributes.Remove("class");
            _rankListItem.Attributes.Remove("class");
            _personaListItem.Attributes.Remove("class");
            _branchListItem.Attributes.Remove("class");
            _installationListItem.Attributes.Remove("class");

            activeTab.CssClass = activeState;
            activeLink.Attributes.Add("class", "active");

        }
    }
}