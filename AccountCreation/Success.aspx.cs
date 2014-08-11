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
                using(var smtp = new SmtpClient("155.214.100.30"))
                {
                    var lineBreak = Environment.NewLine;
                    var doubleLineBreak = Environment.NewLine + Environment.NewLine;
                    var mail = new MailMessage();
                    var emailFromAddress = new MailAddress("Fort Carson Accounts<donotreply.netcom.carsonwebmaster.webmasterinbox@mail.mil>");

                    mail.From = emailFromAddress;
                    mail.To.Add(_supervisorEmail.Text);
                    if (_securityPlaceHolder.Visible)
                    {
                        mail.To.Add(_securityEmail.Text);
                    }
                    mail.Subject = "Fort Carson Accounts: Account verfication requested; DO NOT REPLY";
                    mail.Body += "This is an automated message. Please DO NOT REPLY to this email address" + doubleLineBreak + doubleLineBreak;
                    mail.Body += "This email is to inform you that an account verification request has been submitted by:" + lineBreak + _emailSignature.Text + doubleLineBreak;
                    mail.Body += "Please visit the link below to verify this request." + lineBreak;
                    mail.Body += SearchQuery;
                    mail.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
                    smtp.Send(mail);
                    _multiviewForm.ActiveViewIndex = 1;
                }
            }
        }
	}
}