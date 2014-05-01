using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;

namespace AccountCreation
{
	public class CurrentUser
	{
		public string LastName { get; set; }
		public string FirstName { get; set; }
		public string MiddleInitial { get; set; }
		public string Edipi { get; set; }
		public ADAccount AccountInfo { get; set; }

		public CurrentUser(HttpClientCertificate cac)
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

			LastName = fullName[0].ToString();
			FirstName = fullName[1].ToString();
			// TODO: fix middleinitial
			MiddleInitial = fullName[2].ToString();
			Edipi = cacIdentifier;
			AccountInfo = new ADAccount(cacIdentifier);
		}
	}
}