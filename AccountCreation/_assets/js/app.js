﻿(function ($) {
    $('[data-loading-text]').click(function () {
        $(this).button('loading');
    })
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