$(function() {
  var $cross_check_submit = $('#cross_check_submit');

  $('body').on('keyup', '.cross-checks__textarea--required', function(e) {
    var target = $(e.target);
    var val = target.val();

    if (val.length) {
      var description = target.data('description');
    }

    var disabled = !val.length;

    $('.button--submit')
      .toggleClass('button--disabled', disabled)
      .prop('disabled', disabled);

    $cross_check_submit.prop('disabled', disabled);

    $('.footer-flash')
      .html(description || "")
      .toggleClass('footer-flash--visible', Boolean(description));
  })

  $('.cross-checks__textarea--required').trigger('keyup');
})
