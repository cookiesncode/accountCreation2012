(function ($) {
///////////////////////////////////////////////////////////////////
// Submit button loading text and pop confirmation dialogue modals.
    $(':submit').click(function (event) {
        var $button = $(this);
        var btnLoadingText = $button.attr('data-loading-text');
        var btnConfirmText = $button.attr('data-confirm-modal');
        var $validationLabels = $('.label-warning');
        var passesValidation = true;

        $validationLabels.each(function (index, el) {
            var $label = $(el);
            if ($label.is(':visible')) {
                passesValidation = false;
                return false;
            }
        });
        if (passesValidation && btnLoadingText && !btnConfirmText) {
            $button.button('loading');
            $('#datePicker input:text').removeAttr('disabled'); // JANK: to get ASP.NET to accept the date entered when field is disabled
        }
        if (passesValidation && btnConfirmText) {
            var confirmEntry = confirm(btnConfirmText);
            if (confirmEntry === false) {
                event.preventDefault();
            } else {
                $button.button('loading');
            }
        }
    });
    // The code below is to dynamically add the alert dialogue box if they selected an account deletion.
    var $createDeleteRadio = $('#_requestType :radio');
    var $submitBtn = $('[data-js="delete-alert"]');

    $createDeleteRadio.change(function () {
        $optionSelected = $(this);
        if ($optionSelected.val() === "Delete") {
            $submitBtn.attr('data-confirm-modal','Please confirm that you are requesting an account deletion.');
        }
        else {
            $submitBtn.removeAttr('data-confirm-modal');
        }
    });

///////////////////////////////////////////////////////////////////
// EP unit selected code.
    var $epUnitsList = $('#_epUnitsList');
    $epUnitsList.on('change', function(event) {
        var str = "";
        $epUnitsList.children('option:selected')
        .each(function(index, el) {
            str += $(this).text() + " ";
        });
        $('#_epSelectedUnits').val(str);
    })   

///////////////////////////////////////////////////////////////////
// Datepicker code
    if ($.fn.datepicker) {
        var date = new Date();
        $('#datePicker').attr("data-date", date);
        $('#datePicker').datepicker({
            format: 'm/d/yyyy',
            orientation: 'bottom',
            startDate: '-1y',
            endDate: date
        });
    }

    var $trainingTextBox = $('#_trainingTextBox');
    var $trainingDatePanel = $('#_trainingDatePanel');
    $trainingDatePanel.hide();
    $('#_trainingCheckBox').change(function (e) {
        var $this = $(this);
        if ($this.is(':checked')) {
            $trainingDatePanel.show(300);
            $trainingTextBox.val('checked');
        } else {
            $trainingDatePanel.hide(300);
            $trainingTextBox.val('');
        }
    });

///////////////////////////////////////////////////////////////////
// Popover tooltip code.
    var statusContent = $('<span class="glyphicon glyphicon-info-sign" data-toggle="popover" data-placement="auto top" title="Request Status Stages" data-content="<ul><li>Requested - User submitted request</li><li>Partially Verified - Supervisor signed (Only occurs if two signatures are required)</li><li>Ready - Request is ready to be processed.</li><li>Completed - Request was completed</li><li>Failed - Request failed to be completed</ul>"></span>');
    var requestTypeContent = $('<span class="glyphicon glyphicon-info-sign" data-toggle="popover" data-placement="auto top" title="Request Type Terms" data-content="<p>This field shows whether the user requested a deletion or creation of the <em>Account Type</em>. Do not be confused with the <em>Manual</em> or <em>Auto</em> part. The important piece is whether the request is a <em>Create</em> or <em>Delete</em>."></span>');
    $('.js-popover-status').append(statusContent);
    $('js-popover-request').append(requestTypeContent);
    $('[data-toggle="popover"]').popover({
        html: true,
        trigger: 'hover',
        container: 'body'
    });


///////////////////////////////////////////////////////////////////
// Autopopulate MACOM code.
    var $macom = $('#_macom');
    $('#_masterMainContent__formview__orgUnit').change(function (e) {
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


}(jQuery));