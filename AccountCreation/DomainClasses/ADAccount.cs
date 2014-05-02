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
		public Guid AccountGuid { get; set; }
		public string NiprAccountName { get; set; }
		//public bool VpnAccount { get; set; }
		//public bool EpAccount { get; set; }

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
							NiprAccountName = user.EmployeeId;
							AccountGuid = (Guid)user.Guid;
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

		//public void queryForVpn()
		//{
		//	var domainContext = new PrincipalContext(ContextType.Domain, null, "DC=nanw,DC=ds,DC=army,DC=mil"/* TODO: narrow down further*/);
		//	foreach (string group in VpnAccount.AccountGroups)
		//	{
		//		PrincipalCollection members = GroupPrincipal.FindByIdentity(domainContext, IdentityType.Guid, group).Members;
		//		foreach (Principal member in members)
		//		{
		//			if (member.Guid == AccountGuid)
		//			{

		//			}
		//		}
		//	}

		public bool queryForVpn()
		{
			var domainContext = new PrincipalContext(ContextType.Domain, null, "DC=nanw,DC=ds,DC=army,DC=mil"/* TODO: narrow down further*/);
			foreach (string group in VpnAccount.AccountGroups)
			{
				PrincipalCollection members = GroupPrincipal.FindByIdentity(domainContext, group).Members;
				foreach (Principal member in members)
				{
					// TODO: Check with Ken if its normal for SA accounts to be part of VPN groups
					// If so then this needs to be extended
					if (member.UserPrincipalName == LogonName)
					{
						continue;
					}
				}
			}
			return false;
		}

		public ADAccount(string edipi)
		{
			// TODO check for ending zeros on edipi. It does not show up in AD
			LogonName = edipi + "@mil";
		}
	}
}