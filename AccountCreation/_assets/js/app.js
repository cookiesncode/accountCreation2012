(function ($) {

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

    var $epUnitsList = $('#_epUnitsList');
    $epUnitsList.on('change', function(event) {
        var str = "";
        $epUnitsList.children('option:selected')
        .each(function(index, el) {
            str += $(this).text() + " ";
        });
        $('#_epSelectedUnits').val(str);
    })   

    if ($.fn.datepicker) {
        var date = new Date();
        $('#datePicker').attr("data-date", date);
        $('#datePicker').datepicker({
            format: 'm/d/yyyy',
            orientation: 'bottom'
        });
    }

}(jQuery));