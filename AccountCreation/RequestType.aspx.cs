using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AccountCreation
{
	public partial class RequestType : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			//if (Request.ClientCertificate.IsPresent && !IsPostBack)
			//{
			//	var cac = Request.ClientCertificate;
			//	var user = new CurrentUser(cac);
			//}
		}

		public bool NiprRequest
		{
			get	{ return _niprAcct.Checked;	}
		}

		public bool VpnRequest
		{
			get	{ return _vpnAcct.Checked; }
		}

		public bool SiprRequest
		{
			get	{ return _siprAcct.Checked; }
		}

		public bool EpRequest
		{
			get	{ return _epAcct.Checked; }
		}

	}
}