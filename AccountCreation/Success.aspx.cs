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
		protected void Page_Load(object sender, EventArgs e)
		{
            string requestedAccount = Session["RequestedAccount"] as string;
            if (!IsPostBack)
            {
                if (requestedAccount != null && requestedAccount == "VPN")
                {
                    _securityPlaceHolder.Visible = false;
                }
            }
		}

        protected void _button_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string searchQuery = null;
                string verificationPageWithQuery = null;

                if (Request.QueryString["search"] != null)
                {
                    searchQuery = Request.QueryString["search"];
                    verificationPageWithQuery = "https://nec.carson.army.mil/account-creation/Verification.aspx?search=" + searchQuery;
                }

                using(var smtp = new SmtpClient("155.214.100.30"))
                {
                    var mail = new MailMessage();
                    var supervisorText = _supervisorEmail.Text;
                    var securityText = _securityEmail.Text;
                    var emailFromAddress = new MailAddress("miguel.gomez16.ctr@mail.mil");

                    if (supervisorText.Length > 0)
                    {
                        mail.To.Add(supervisorText);
                    }
                    if (securityText.Length > 0)
                    {
                        mail.To.Add(securityText);
                    }

                    mail.From = emailFromAddress;
                    mail.Subject = "Account Creation Email";
                    mail.Body = verificationPageWithQuery;
                    mail.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
                    smtp.Send(mail);
                    _multiviewForm.ActiveViewIndex = 1;
                }
            }
        }
	}
}