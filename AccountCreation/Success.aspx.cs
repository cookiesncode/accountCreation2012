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
                    var emailToAddress = new MailAddress(_email.Text);
                    var emailFromAddress = new MailAddress("miguel.gomez16.ctr@mail.mil");
                  
                    mail.From = emailFromAddress;
                    mail.To.Add(emailToAddress);
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