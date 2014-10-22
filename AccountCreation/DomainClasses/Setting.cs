using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace AccountCreation
{
	static class Setting
	{
		public static Dictionary<string, string> VpnGroups 
		{
			get
			{
				return new Dictionary<string, string> 
				{
					{ "Doim", "3ffcbc92-dada-48a7-922c-c56ab52ac09f" },
					{ "External", "d2cf5aad-640d-4cbd-886d-ab6cd22d6249" },
					{ "Mep", "670b7556-9a0d-4540-a737-f5ff3f9579f4" },
					{ "Users", "8d5eeb8f-e7ee-4ceb-a2b0-bc9c4a4904af" },
					{ "Vip", "e64d3570-b82f-4af9-9ee6-b8c0e6040639" }
				};
			}
		}

		public static string[] Macom
		{
			get
			{
				return new string[]
				{
					"AMC",
					"ASA/ALT",
					"CHRA",
					"DFAS",
					"FMWRC",
					"FORSCOM",
					"HRC",
					"IMCOM",
					"INSCOM",
					"MEDCOM",
					"NETCOM",
					"STRATCOM",
					"USACIDC",
					"USARC",
					"USASOC",
					"US-TRANSCOM"
				};
			}
		}
 
        public static List<string> InstallationList
        {
            get
            {
                var context = new SettingEntities();
                var query = from record in context.Installations
                            select record.InstallationName;
                return query.ToList();
            }
        }

        public static List<string> UnitList
        {
            get
            {
                var context = new SettingEntities();
                var query = from record in context.UnitOrgs
                            select record.UnitName;
                return query.ToList();
            }
        }

        public static List<string> BranchList
        {
            get
            {
                var context = new SettingEntities();
                var query = from record in context.Branches
                            select record.BranchName;
                return query.ToList();
            }
        }

        public static List<string> PersonaList
        {
            get
            {
                var context = new SettingEntities();
                var query = from record in context.Personas
                            select record.PersonaName;
                return query.ToList();
            }
        }

        public static List<string> RankList
        {
            get
            {
                var context = new SettingEntities();
                var query = from record in context.Ranks
                            select record.RankName;
                return query.ToList();
            }
        }
	}
}