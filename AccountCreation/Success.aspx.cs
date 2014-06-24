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
        private string VerificationLink
        {
            get
            {
                string searchQuery = Request.QueryString["search"];
                if (searchQuery != null)
                {
                    return "https://nec.carson.army.mil/account-creation/verification.aspx?search=" + searchQuery;
                }
                else
                {
                    return null;
                }
            }
        }

		protected void Page_Load(object sender, EventArgs e)
		{
            string requestedAccount = Session["RequestedAccount"] as string;
            if (!IsPostBack && VerificationLink != null)
            {
                var firstName = CacCard.FirstName;
                var lastName = CacCard.LastName;
                if (requestedAccount != null && requestedAccount == "VPN")
                {
                    _securityPlaceHolder.Visible = false;
                }
                _verificationLink.Text = VerificationLink;
                _emailSignature.Text = firstName + " " + lastName;
            }
            else if (!IsPostBack && VerificationLink == null)
            {
                Response.Redirect("~/Default.aspx", true);
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
                    var emailFromAddress = new MailAddress("Fort Carson Accounts<netcom.carsonwebmaster.webmasterinbox@mail.mil>");

                    mail.From = emailFromAddress;
                    mail.To.Add(_supervisorEmail.Text);
                    if (_securityPlaceHolder.Visible)
                    {
                        mail.To.Add(_securityEmail.Text);
                    }
                    mail.Subject = "Fort Carson Accounts: New account verification request";
                    mail.Body += "This email is to inform you that an account verification request has been submitted by:" + lineBreak + _emailSignature.Text + doubleLineBreak;
                    mail.Body += "Please visit the link below to verify this request." + lineBreak; 
                    mail.Body += VerificationLink;
                    mail.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
                    smtp.Send(mail);
                    _multiviewForm.ActiveViewIndex = 1;
                }
            }
        }
	}
}