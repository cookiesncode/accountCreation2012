using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace AccountCreation
{
    // This Class is responsible for parsing the information found in the user's CAC card and extracting the desired values.
    // This is an example of the string that is found in the CAC card for a user WITH a middle name: C=US, O=U.S. Government, OU=DoD, OU=PKI, OU=CONTRACTOR, CN=LASTNAME.FIRSTNAME.MIDDLENAME.1265020972
    // This is an example of the string that is found in the CAC card for a user WITHOUT a middle name: C=US, O=U.S. Government, OU=DoD, OU=PKI, OU=CONTRACTOR, CN=LASTNAME.FIRSTNAME.1265020972
    public static class CacCard
	{
		public static string LastName
		{
			get
			{
				HttpClientCertificate cacCard = HttpContext.Current.Request.ClientCertificate;
				if (cacCard.IsPresent)
				{
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
				else
				{
					return null;
				}
			}
		}
		
		public static string FirstName
		{
			get
			{
				HttpClientCertificate cacCard = HttpContext.Current.Request.ClientCertificate;
				if (cacCard.IsPresent)
				{
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
				else
				{
					return null;
				}
			}
		}
		
		public static string Edipi
		{
			get
			{
				HttpClientCertificate cacCard = HttpContext.Current.Request.ClientCertificate;
				if (cacCard.IsPresent)
				{
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
				else
				{
					return null;
				}
			}
		}
       
        public static string MiddleInitial
        {
            get
            {
                HttpClientCertificate cacCard = HttpContext.Current.Request.ClientCertificate;
                if (cacCard.IsPresent)
                {
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
                    string middleName = fullName[2].ToString();
                    string middleInitial = middleName[0].ToString();
                    // The following statements checks whether the value found in the middleInitial variable is a integer or a letter.
                    // If it is an integer then an empty string is returned.
                    int valueReturned;
                    bool isInteger = int.TryParse(middleInitial, out valueReturned);              
                    if (isInteger)
                    {
                        return "";
                    }
                    else
                    {
                        return middleInitial;
                    }
                }
                else
                {
                    return null;
                }
            }
        }
    }
}