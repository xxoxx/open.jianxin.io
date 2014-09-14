(function ($) {
    // add class[.active] for current action
    var current_path = window.location.pathname || '/';
    var current_action = current_path.split('/')[1] || 'todo';
    $('#global-header-nav').find('.' + current_action).addClass('active');

    // add cookie if user prefer ignore describe
    $('#btn-ignore-subscribe').click(function () {
        $.cookie('ignore_subscribe', '1', { expires: 300, path: '/' });
    });

})(jQuery);