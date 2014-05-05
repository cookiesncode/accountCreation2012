using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;

namespace AccountCreation
{
	public class CurrentUser : Page
	{
		public string LastName { get; set; }
		public string FirstName { get; set; }
		public string MiddleInitial { get; set; }
		public string Edipi { get; set; }
		public ADAccount AccountInfo { get; set; }

		public CurrentUser(string edipi)
		{
			AccountInfo = new ADAccount(edipi);
		}

		public CurrentUser()
		{
			HttpClientCertificate cacCardInfo = Request.ClientCertificate;
			string[] subjectArray = cacCardInfo.Subject.Split(',');
			string subjectLine = cacCardInfo.Subject.ToString();
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

			LastName = fullName[0].ToString();
			FirstName = fullName[1].ToString();
			// TODO: fix middleinitial
			MiddleInitial = fullName[2].ToString();
			Edipi = cacIdentifier;
			AccountInfo = new ADAccount(cacIdentifier);
		}
	}
}