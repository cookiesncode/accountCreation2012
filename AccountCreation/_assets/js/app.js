(function ($) {
    var $disabledFields = $('[data-js-datepicker] input:text');

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
        if (passesValidation) {
            $disabledFields.removeAttr('disabled'); // JANK: to get ASP.NET to accept the date entered when field is disabled
        }
        if (passesValidation && btnLoadingText && !btnConfirmText) {
            $button.button('loading');
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

    $('[data-js="remove-disabled"]').change(function () {
        $disabledFields.removeAttr('disabled');
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
    // Print button
    $('#print-btn').click(function (event) {
        window.print();
    });

    ///////////////////////////////////////////////////////////////////
    // Hide first IT Level radio option (JANK)
    $('[data-js="hidden-radio"] .aspNetDisabled').add('[data-js="hidden-radio"] > br:first').remove();
   


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
    // Datepicker code: Note: The submit button code above affects the datepicker as well (JANK)

    if ($.fn.datepicker) {
        var todaysDate = new Date();
        var $trainingDate = $('[data-js-datepicker="training-date"]');
        var $deleteDate = $('[data-js-datepicker="delete-date"]');
        var $investigationDate = $('[data-js-datepicker="investigation-date"]');
        $trainingDate.attr("data-date", todaysDate);
        $deleteDate.attr("data-date", todaysDate);
        $investigationDate.attr("data-date", todaysDate);

        $deleteDate.datepicker({
            format: 'm/d/yyyy',
            endDate: '+2m',
            startDate: todaysDate,
            todayBtn: true
        });
        $trainingDate.datepicker({
            format: 'm/d/yyyy',
            orientation: 'bottom',
            startDate: '-1y',
            endDate: todaysDate,
            todayBtn: true
        });
        $investigationDate.datepicker({
            format: 'm/d/yyyy',
            orientation: 'bottom',
            startDate: '-10y',
            endDate: todaysDate,
            todayBtn: true
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
    var epTypeContent = $('<span class="glyphicon glyphicon-info-sign" data-toggle="popover" data-placement="auto top" title="Logon Only" data-content="Choose this option if you need an account for logging on to a computer running some type of wall monitor displaying information of use to personnel/passers-by in your unit or organization.</p> <p>This is a basic user account - <strong>No e-mail access or privileges.</strong></p>"></span>');
    var saTypeContent = $('<span class="glyphicon glyphicon-info-sign" data-toggle="popover" data-placement="auto top" title="SA Account (Previously known as SA/EP)" data-content="<p>Choose this option if you need an account with administrative privileges on a select group of computers you support.</p> <p><strong>This is a privilege - not a right. You are responsible to keep your information in ATCTS current.</strong></p> <p>Intended for Soldiers with MOS 25B or 25U in skill level 10, E1-E4; DA Civilians in series 2210; contractors on a NEC-sponsored contract.</p>"></span>');
    $('.js-popover-status').append(statusContent);
    $('.js-popover-request').append(requestTypeContent);
    $('#_accountType_2 + label').append(epTypeContent);
    $('#_accountType_3 + label').append(saTypeContent);
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