$(function() {
  var $crossCheckSubmit = $('#cross_check_submit');

  var verifyRequiredFields = function(e) {
    var description
    var elementsNeedInput = Boolean($('.cross-checks__input--required').filter(function() {
      return $(this).val().length <= 0
    }).length)

    $('.button--submit')
      .toggleClass('button--disabled', elementsNeedInput)
      .prop('disabled', elementsNeedInput)

    $crossCheckSubmit.prop('disabled', elementsNeedInput)
  }

  displayDescription = function(e) {
    if ($(this).val().length) {
      var description = $(this).data('description')
    }

    $('.footer-flash')
      .html(description || "")
      .toggleClass('footer-flash--visible', Boolean(description))
  }

  $('body').on('keyup', '.cross-checks__input--required', verifyRequiredFields)
  $('body').on('keyup', '.cross-checks__textarea[data-description]', displayDescription)
  $('body').on('change', 'select.cross-checks__input--required', verifyRequiredFields)
  $('.cross-checks__input--required').trigger('keyup');
  $('.cross-checks__textarea').trigger('keyup');
})
