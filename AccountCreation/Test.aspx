<%@ Page Title="" Language="C#" MasterPageFile="~/MainLayout.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" ClientIDMode="Static" Inherits="AccountCreation.Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="_masterHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="_masterMainContent" runat="server">
	<div><asp:Label ID="_cacTest" runat="server" Text="Test Label"></asp:Label></div>
	<div><asp:Label ID="_cacCert" runat="server" Text="Test Label"></asp:Label></div>
	<div><asp:Label ID="_cacMiddleInitial" runat="server" Text="Test Label"></asp:Label></div>

	<div><asp:Label ID="_currentUser" runat="server" Text="Test Label"></asp:Label></div>
	
	<div><asp:Label ID="_niprAccount" runat="server" Text="Test Label"></asp:Label></div>

	<div><asp:Label ID="Label3" runat="server" Text="Test Label"></asp:Label></div>
    <asp:DropDownList ID="_units" runat="server"></asp:DropDownList>
    <asp:TextBox ID="_macom" runat="server"></asp:TextBox>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="_masterBtmScripts" runat="server">
<%--    <script>
        var $macom = $('#_macom');
        $('#_units').change(function (e) {
            var $this = $(this);
            var selectedItem = $this.find('option:selected').text();
            switch (selectedItem) {
                case 'AFSBN':
                case 'DOL':
                case 'MICC':
                case 'PCD':
                case 'TMDE':
                    $macom.val('AMC');
                    break;
                case 'BFT':
                    $macom.val('ASA_ALT');
                    break;
                case 'CPAC':
                    $macom.val('CHRA');
                    break;
                case 'DMPO':
                    $macom.val('DFAS');
                    break;
                case 'WCAP':
                    $macom.val('FMWRC');
                    break;
                case '1-25ATK':
                case '4EN':
                case '4ID':
                case '4ID 1BCT':
                case '4ID 1BCT 1-38IN':
                case '4ID 1BCT 1STB':
                case '4ID 1BCT 2-23IN':
                case '4ID 1BCT 4BSB':
                case '4ID 1BCT HQ':
                case '4ID 1SBCT 2-1CAV':
                case '4ID 1SBCT 2-12FA':
                case '4ID 1SBCT 4-9IN':
                case '4ID 2BCT':
                case '4ID 2BCT 1-10CAV':
                case '4ID 2BCT 1-67AR':
                case '4ID 2BCT 2-8IN':
                case '4ID 2BCT 2STB':
                case '4ID 2BCT 3-16FA':
                case '4ID 2BCT 204BSB':
                case '4ID 2BCT HQ':
                case '4ID 3BCT':
                case '4ID 3BCT 1-8IN':
                case '4ID 3BCT 1-66AR':
                case '4ID 3BCT 1-68AR':
                case '4ID 3BCT 3-29FA':
                case '4ID 3BCT 3STB':
                case '4ID 3BCT 4-10CAV':
                case '4ID 3BCT 64BSB':
                case '4ID 3BCT HQ':
                case '4ID 4BCT':
                case '4ID 4BCT 1-12IN':
                case '4ID 4BCT 2-12IN':
                case '4ID 4BCT 2-77FA':
                case '4ID 4BCT 3-61CAV':
                case '4ID 4BCT 4STB':
                case '4ID 4BCT 704BSB':
                case '4ID 4BCT HQ':
                case '4ID 4CAB 1-4ARB':
                case '4ID 4CAB 2-4GSAB':
                case '4ID 4CAB 3-4AHB':
                case '4ID 4CAB 4-4ARB':
                case '4ID 4CAB 404ASB':
                case '4ID 4CAB HHC':
                case '4ID DSTB':
                case '4ID HQ':
                case '4ID-CMD-GRP':
                case '10CSH':
                case '43SB':
                case '43SB 43BSTB':
                case '43SB 68CSB':
                case '52EN':
                case '71EOD':
                case '759MP':
                case 'DRM':
                case 'MSE':
                case 'OSJA':
                    $macom.val('FORSCOM');
                    break;
                case 'iPERMS':
                    $macom.val('HRC');
                    break;
                case '1MOB':
                case '13ASOS':
                case 'ACS':
                case 'ARC':
                case 'DES':
                case 'DET1-3WS':
                case 'DFMWR':
                case 'DHR':
                case 'DPTMS':
                case 'DPW':
                case 'EEO':
                case 'GRM':
                case 'GSD':
                case 'Lenel':
                case 'PAO':
                case 'Safety':
                case 'USAG':
                case 'USARE-DISA DET 3':
                    $macom.val('IMCOM');
                    break;
                case '704MI':
                case '902MI':
                    $macom.val('INSCOM');
                    break;
                case 'MEDDAC':
                    $macom.val('MEDCOM');
                    break;
                case 'NEC':
                    $macom.val('NETCOM');
                    break;
                case 'JTAGS':
                    $macom.val('STRATCOM');
                    break;
                case '48MP':
                    $macom.val('USACIDC');
                    break;
                case 'ROTC':
                    $macom.val('USARC');
                    break;
                case '10SFG':
                    $macom.val('USASOC');
                    break;
                case 'DCS':
                    $macom.val('US-TRANSCOM');
                    break;
                default:
                    $macom.val('Select a unit');
            }
        });
    </script>--%>

</asp:Content>
