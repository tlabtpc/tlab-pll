$(function() {
  $('.primary-referrals-show').on('change', '.primary-referrals__locale', function(e) {
    var locale = $(e.target).val();

    $('#email_language').val(locale);

    $('.primary-referrals__markdown').addClass('hide');
    $('.primary-referrals__markdown[data-locale=' + locale + ']').removeClass('hide');
  })
});
