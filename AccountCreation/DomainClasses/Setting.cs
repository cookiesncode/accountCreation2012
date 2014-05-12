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

		public static string[] Rank
		{
			get
			{
				var rankArray = new string[] 
				{
					"CIV",
					"CTR",
					"NAF",
					"NGO",
					"PVT",
					"PV2",
					"PFC",
					"SPC",
					"CPL",
					"SGT",
					"SSG",
					"SFC",
					"MSG",
					"1SG",
					"SGM",
					"CSM",
					"SMA",
					"WO1",
					"CW2",
					"CW3",
					"CW4",
					"CW5",
					"2LT",
					"1LT",
					"CPT",
					"MAJ",
					"LTC",
					"COL",
					"BG",
					"MG",
					"LTG",
					"GEN",
					"AF-AB",
					"AF-Amn",
					"AF-A1C",
					"AF-SrA",
					"AF-SSgt",
					"AF-TSgt",
					"AF-MSgt",
					"AF-1SG",
					"AF-SMSgt",
					"AF-1SG",
					"AF-CMSgt",
					"AF-1SG",
					"AF-CCM",
					"AF-CMSAF",
					"AF-2d Lt",
					"AF-1st Lt",
					"AF-Capt",
					"AF-Maj",
					"AF-Lt Col",
					"AF-Col",
					"AF-Brig Gen",
					"AF-Maj Gen",
					"AF-Lt Gen",
					"AF-Gen",
					"AF-GAF",
					"CG-SR",
					"CG-SA",
					"CG-FA ",
					"CG-AA",
					"CG-SN",
					"CG-FN",
					"CG-AN",
					"CG-PO3",
					"CG-PO2",
					"CG-PO1",
					"CG-CPO",
					"CG-SCPO",
					"CG-MCPO",
					"CG-CMCPO",
					"CG-CWO2",
					"CG-CWO3",
					"CG-CWO4",
					"CG-ENS",
					"CG-LTJG",
					"CG-LT",
					"CG-LCDR",
					"CG-CDR",
					"CG-CAPT",
					"CG-RDML",
					"CG-RADM",
					"CG-VADM",
					"CG-ADM",
					"N-SR",
					"N-SA",
					"N-SN",
					"N-PO3",
					"N-PO2",
					"N-PO1",
					"N-CPO",
					"N-SCPO",
					"N-MCPO",
					"N-CMCPO",
					"N-WO1",
					"N-CWO2",
					"N-CWO3",
					"N-CWO4",
					"N-CWO5",
					"N-ENS",
					"N-LTJG",
					"N-LT",
					"N-LCDR",
					"N-CDR",
					"N-CAPT",
					"N-RDML",
					"N-RADM",
					"N-VADM",
					"N-ADM",
					"Mar-Pvt",
					"Mar-PFC",
					"Mar-LCpl",
					"Mar-Cpl",
					"Mar-Sgt",
					"Mar-SSgt",
					"Mar-GySgt",
					"Mar-MSgt",
					"Mar-1stSgt",
					"Mar-MGySgt",
					"Mar-SgtMaj",
					"Mar-SgtMajMarCor",
					"Mar-W1",
					"Mar-W2",
					"Mar-W3",
					"Mar-W4",
					"Mar-W5",
					"Mar-2ndLt",
					"Mar-1stLt",
					"Mar-Capt",
					"Mar-Maj",
					"Mar-LtCol",
					"Mar-Col",
					"Mar-Bgen",
					"Mar-MajGen",
					"Mar-LtGen",
					"Mar-Gen",
					"Cadet"
				};
				return rankArray;
			}
		}
	}
}