using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.DirectoryServices.ActiveDirectory;

namespace AccountCreation
{
	public class ADAccount
	{
		public string LogonName { get; set; }
		public string NiprAccountName { get; set; }
		public bool VpnAccount { get; set; }
		public bool EpAccount { get; set; }

		public bool queryForNipr()
		{
			var forest = Forest.GetForest(new DirectoryContext(DirectoryContextType.Forest, "ds.army.mil"));
			var domains = forest.Domains;
			PrincipalContext domainContext;
			UserPrincipal user;

			foreach (Domain domain in domains)
			{
				domainContext = new PrincipalContext(ContextType.Domain, null, domain.ToString());
				try
				{
					using (user = UserPrincipal.FindByIdentity(domainContext, LogonName))
					{
						if (user != null)
						{
							NiprAccountName = user.DisplayName;
							return true;
						}
					}
				}
				catch
				{

				}
			}
			return false;
		}

		public ADAccount(string edipi)
		{
			LogonName = edipi + "@mil";
		}
	}
}