$(function() {
  if ($('body').find('.cross-checks__textarea--required').length) {
    $('.button--submit').addClass('button--disabled')
  }

  $('body').on('keyup', '.cross-checks__textarea--required', function(e) {
    var target = $(e.target)
    var val = target.val()
    if (val.length) {
      var description = target.data('description')
    }

    $('.button--submit').toggleClass('button--disabled', !!!val.length)
    $('.footer-flash').html(description || "").toggleClass('footer-flash--visible', !!description)
  })
})
