using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;

namespace AccountCreation
{
    public class Email
    {
        public static void SendEmail(string toAddress, string message, string signature, string searchUrl)
        {
            using (var smtp = new SmtpClient("155.214.100.30"))
            {
                var lineBreak = Environment.NewLine;
                var doubleLineBreak = Environment.NewLine + Environment.NewLine;
                var mail = new MailMessage();

                mail.From = new MailAddress("Fort Carson Accounts<donotreply.netcom.carsonwebmaster.webmasterinbox@mail.mil>");
                mail.To.Add(toAddress);
                mail.Subject = "Fort Carson Accounts: Account verfication requested; DO NOT REPLY";
                mail.Body += "This is an automated message. Please DO NOT REPLY to this email address" + doubleLineBreak + doubleLineBreak;
                mail.Body += "This email is to inform you that an account verification request has been submitted by:" + lineBreak + signature + doubleLineBreak;
                mail.Body += message + lineBreak;
                mail.Body += searchUrl;
                mail.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
                smtp.Send(mail);
            }
        }
    }
}