using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;

namespace AccountCreation
{
    public class Email
    {
        public static void SendEmail(string toAddress, string messageAddon, string signature, string appLink, string accountType, bool isInitialCustomerMessage)
        {
            using (var smtp = new SmtpClient("155.214.100.30"))
            {
                var lineBreak = Environment.NewLine;
                var doubleLineBreak = Environment.NewLine + Environment.NewLine;
                var mail = new MailMessage();
                string defaultMessage;

                if (isInitialCustomerMessage)
                {
                    defaultMessage = "This email is to inform you that a " + accountType + " account request has been submitted by:";
                }
                else
                {
                    defaultMessage = "This email is to inform you that a " + accountType + " account request has been updated by:";
                }

                mail.From = new MailAddress("Fort Carson Accounts<donotreply.netcom.carsonwebmaster.webmasterinbox@mail.mil>");
                mail.To.Add(toAddress);
                mail.Subject = "Fort Carson Accounts: account verification requested; DO NOT REPLY";
                mail.Body += "This is an automated message. Please DO NOT REPLY to this email address" + doubleLineBreak + doubleLineBreak;
                mail.Body += defaultMessage + lineBreak + signature + doubleLineBreak;
                mail.Body += messageAddon + doubleLineBreak;
                mail.Body += "Link to the account request:" + lineBreak;
                mail.Body += appLink;
                mail.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
                smtp.Send(mail);
            }
        }
    }
}