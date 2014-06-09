(function ($) {
    $('[data-loading-text]').click(function () {
    	var $button = $(this);
        var $validationLabels = $('.label-warning');
        $button.button('loading');
        $validationLabels.each(function (index, el) {
        	var $label = $(el);
        	if ($label.is(':visible')) {
        		$button.button('reset');
        		return true;
        	}
        });
    });

    var $epUnitsList = $('#_epUnitsList');
    $epUnitsList.on('change', function(event) {
        var str = "";
        $epUnitsList.children('option:selected')
        .each(function(index, el) {
            str += $(this).text() + " ";
            $('#_epSelectedUnits').val(str);
        });
    })
    .change();
}(jQuery));


//var ua = navigator.userAgent.toLowerCase();
//var isAndroid = ua.indexOf("android") > -1; //&& ua.indexOf("mobile");
//var isIEMobile = ua.indexOf("iemobile") > -1; //&& ua.indexOf("mobile");
//if (!isAndroid && !isIEMobile) {
//	$('[data-input-mask="tel"]').mask('(999) 999-9999');
//	$('[data-input-mask="ssn"]').mask('999-99-9999');
//	$('[data-input-mask="date"]').mask('99/99/9999');
//	$('[data-input-mask="tag"]').mask('99/99');
//	$('[data-input-mask="time"]').mask('99:99');
//}