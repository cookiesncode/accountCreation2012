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
		public string VpnGroupName { get; set; }

		public ADAccount(string edipi)
		{
			LogonName = edipi + "@mil";
		}

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

		public bool queryForVpn()
		{
			var domainContext = new PrincipalContext(ContextType.Domain, null, "OU=Special Groups,OU=NETCOM,OU=Fort Carson,OU=Carson,OU=Installations,DC=nanw,DC=ds,DC=army,DC=mil");
			GroupPrincipal vpnGroup;
			PrincipalCollection members;

			foreach (string group in Vpn.GroupCollection)
			{
				try
				{
					using (vpnGroup = GroupPrincipal.FindByIdentity(domainContext, group))
					{
						members = vpnGroup.Members;
						foreach (Principal member in members)
						{
							if (member.UserPrincipalName == LogonName)
							{
								VpnGroupName = vpnGroup.Name;
								return true;
							}
						}
					}
				}
				catch
				{
				}
			}
			// check if im returning in the right spot
			return false;
		}
	}
}