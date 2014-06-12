using System;
using System.Collections.Generic;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.DirectoryServices.ActiveDirectory;
using System.Linq;
using System.Web;

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

		public ADAccount()
		{
			LogonName = HttpContext.Current.User.Identity.Name;
		}

		public bool queryForest()
		{
			var forest = Forest.GetForest(new DirectoryContext(DirectoryContextType.Forest, "ds.army.mil"));
			var domains = forest.Domains;
			PrincipalContext domainContext;
			UserPrincipal user;

			foreach (Domain domain in domains)
			{
				domainContext = new PrincipalContext(ContextType.Domain, null, domain.Name);
				try
				{
					using (user = UserPrincipal.FindByIdentity(domainContext, LogonName))
					{
						if (user != null)
						{
							if (domain.Name == "nanw.ds.army.mil")
							{
								var visitorContext = new PrincipalContext(ContextType.Domain, null, "OU=_DoDVisitor,OU=Installations,DC=nanw,DC=ds,DC=army,DC=mil");
								var deUser = user.GetUnderlyingObject() as DirectoryEntry;
								var deUserContainer = deUser.Parent.Name;
								// checks if the user in the _DoDVisitor OU.
								if (deUserContainer == "OU=Carson")
								{
									continue;
								}
								else
								{
									NiprAccountName = user.DisplayName;
									return true;
								}
							}
							else
							{
								NiprAccountName = user.DisplayName;
								return true;
							}
						}
					}
				}
				catch
				{
				}
			}
			return false;
		}

		public bool queryVpn()
		{
			var domainContext = new PrincipalContext(ContextType.Domain, null, "OU=Special Groups,OU=NETCOM,OU=Fort Carson,OU=Carson,OU=Installations,DC=nanw,DC=ds,DC=army,DC=mil");
			GroupPrincipal vpnGroup;
			PrincipalCollection members;

			foreach (var group in Setting.VpnGroups.Values)
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
			return false;
		}

		public bool queryOurDomain()
		{
			var domainContext = new PrincipalContext(ContextType.Domain, null, "DC=nanw,DC=ds,DC=army,DC=mil");
			UserPrincipal user = null;
			try
			{
				using (user = UserPrincipal.FindByIdentity(domainContext, LogonName))
				{
					if (user != null)
					{
						var visitorContext = new PrincipalContext(ContextType.Domain, null, "OU=_DoDVisitor,OU=Installations,DC=nanw,DC=ds,DC=army,DC=mil");
						var deUser = user.GetUnderlyingObject() as DirectoryEntry;
						var deUserContainer = deUser.Parent.Name;
						// checks if the user in the _DoDVisitor OU.
						if (deUserContainer == "OU=Carson")
						{
							return false;
						}
						else
						{
							NiprAccountName = user.DisplayName;
							return true;
						}
					}
				}
			}
			catch
			{
			}
			return false;
		}
	}
}