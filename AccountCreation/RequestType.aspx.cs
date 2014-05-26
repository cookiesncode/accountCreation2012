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
		}

		protected void _submitBtn_Click(object sender, EventArgs e)
		{

		}

		public RadioButtonList RequestedAccount
		{
			get { return _requestType; }
		}

		//public bool NiprRequest
		//{
		//	get	{ return _niprAcct.Checked;	}
		//}

		//public bool VpnRequest
		//{
		//	get	{ return _vpnAcct.Checked; }
		//}

		//public bool SiprRequest
		//{
		//	get	{ return _siprAcct.Checked; }
		//}

		//public bool EpRequest
		//{
		//	get	{ return _epAcct.Checked; }
		//}

		//public bool SaRequest
		//{
		//	get { return _saAcct.Checked; }
		//}
	}
}