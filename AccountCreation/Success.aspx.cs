using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

namespace AccountCreation
{
	public partial class Success : System.Web.UI.Page
	{
        private string SearchQuery
        {
            get
            {
                bool formSuccess = false;
                if (Session["FormSubmitted"] != null)
                {
                    formSuccess = (bool)Session["FormSubmitted"];
                }
                if (formSuccess == true)
                {
                    return "https://nec.carson.army.mil/accounts/verification.aspx?search=" + CacCard.Edipi;
                }
                else
                {
                    return null;
                }
            }
        }

		protected void Page_Load(object sender, EventArgs e)
		{
            string accountType = Session["AccountType"] as string;
            string requestType = Session["RequestType"] as string;
            if (!IsPostBack && SearchQuery != null && accountType != null && requestType != null)
            {
                if (accountType == "VPN" || requestType == "Delete")
                {
                    _securityPlaceHolder.Visible = false;
                }
                _verificationLink.Text = SearchQuery;
                _emailSignature.Text = CacCard.FirstName + " " + CacCard.LastName;
            }
            else if (!IsPostBack && SearchQuery == null)
            {
                Server.Transfer("~/default.aspx");
            }
		}

        protected void _button_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string accountType = Session["AccountType"] as string;
                var emailToList = _supervisorEmail.Text;
                if (_securityPlaceHolder.Visible)
                {
                    emailToList += "," + _securityEmail.Text;
                }
                var message = "Use the link below to review this request. If you approve of this request, then you will need to sign the form in order to move the process along.";
                Email.SendEmail(emailToList, message, _emailSignature.Text, SearchQuery, accountType, true);
                _multiviewForm.ActiveViewIndex = 1;
                _instructions.Visible = false;
            }
        }
	}
}