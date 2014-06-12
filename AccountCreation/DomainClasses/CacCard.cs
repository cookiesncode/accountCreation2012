using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace AccountCreation
{
	public static class CacCard
	{
		public static string LastName
		{
			get
			{
				HttpClientCertificate cacCard = HttpContext.Current.Request.ClientCertificate;
				string[] subjectArray = cacCard.Subject.Split(',');
				string subjectLine = cacCard.Subject.ToString();
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

				return fullName[0].ToString();
			}
		}
		
		public static string FirstName
		{
			get
			{
				HttpClientCertificate cacCard = HttpContext.Current.Request.ClientCertificate;
				string[] subjectArray = cacCard.Subject.Split(',');
				string subjectLine = cacCard.Subject.ToString();
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

				return fullName[1].ToString();
			}
		}
		
		public static string Edipi
		{
			get
			{
				HttpClientCertificate cacCard = HttpContext.Current.Request.ClientCertificate;
				string[] subjectArray = cacCard.Subject.Split(',');
				string subjectLine = cacCard.Subject.ToString();
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

				return cacIdentifier;
			}
		}
	}
}