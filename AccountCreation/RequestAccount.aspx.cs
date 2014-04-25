using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Text;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;

namespace AccountCreation
{
	public partial class RequestAccount : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			// RETRIEVE CAC CARD INFO
			/////////////////////////////////////////////////////
			HttpClientCertificate cac = Request.ClientCertificate;
			if (cac.IsPresent && !IsPostBack)
			{
				string[] subjectArray = cac.Subject.Split(',');
				string subjectLine = cac.Subject.ToString();
				int subjectLineLength = subjectLine.Length;
				const int edipiLength = 10;
				int cacIdentifierPosition = subjectLineLength - edipiLength;
				string cacIdentifier = subjectLine.Substring(cacIdentifierPosition, edipiLength);
				string[] arr = subjectArray[5].Split(' ');
				string[] user = arr[1].Split('=');

				StringBuilder sb = new StringBuilder();
				foreach (string field in user)
				{
					sb.Append(field);
				}
				sb.Remove(0, 2);

				string str1 = sb.ToString();
				string[] fullName = str1.Split('.');
				string lastName = fullName[0].ToString();
				string firstName = fullName[1].ToString();
				string middleInitial = fullName[2].ToString();
				string edipi = cacIdentifier;

				// Add cac info into textbox fields
				if (uiAccountRequestForm.CurrentMode == FormViewMode.Insert)
				{
					var uiEdipi = (TextBox)(uiAccountRequestForm).FindControl("uiEdipi");
					var uiLname = (TextBox)(uiAccountRequestForm).FindControl("uiLname");
					var uiFname = (TextBox)(uiAccountRequestForm).FindControl("uiFname");
					//var dateCreated = (TextBox)(uiAccountRequestForm).FindControl("uiDateCreated");

					uiEdipi.Text = edipi;
					uiLname.Text = lastName;
					uiFname.Text = firstName;
					//dateCreated.Text = DateTime.Now.ToShortDateString();
				}

			}

		}

		protected void uiNiprAcct_CheckedChanged(object sender, EventArgs e)
		{

		}

		protected void uiSaAcct_CheckedChanged(object sender, EventArgs e)
		{

		}

		protected void uiEpAcct_CheckedChanged(object sender, EventArgs e)
		{

		}

		protected void uiVpnAcct_CheckedChanged(object sender, EventArgs e)
		{

		}
	}
}