$(function() {
  var $crossCheckSubmit = $('#cross_check_submit');

  var verifyRequiredFields = function(e) {
    var description
    var elementsNeedInput = Boolean($('.cross-checks__input--required').filter(function() {
      return $(this).val().length <= 0
    }).length)

    if (!elementsNeedInput) {
      description = $(e.target).data('description')
    }

    $('.button--submit')
      .toggleClass('button--disabled', elementsNeedInput)
      .prop('disabled', elementsNeedInput)

    $crossCheckSubmit.prop('disabled', elementsNeedInput)

    $('.footer-flash')
      .html(description || "")
      .toggleClass('footer-flash--visible', Boolean(description))
  }

  $('body').on('keyup', 'input.cross-checks__input--required', verifyRequiredFields)
  $('body').on('change', 'select.cross-checks__input--required', verifyRequiredFields)
  $('.cross-checks__input--required').trigger('keyup');
})
