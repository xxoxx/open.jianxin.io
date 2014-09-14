(function ($) {
    $.cookie('ignore_subscribe', '1', { expires: 1, path: '/' });

    setTimeout(function () {
        window.location.replace('/');
    }, 3000);
})(jQuery);