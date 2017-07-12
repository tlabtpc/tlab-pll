$(function() {
  if ($('body').find('.cross-checks__textarea--required').length) {
    $('.button--submit').addClass('button--disabled')
  }

  $('body').on('keyup', '.cross-checks__textarea--required', function(e) {
    let target = $(e.target)
    if ($(e.target).val().length) {
      $('.button--submit').removeClass('button--disabled')
      if (target.data('description')) {
        $('.footer-flash').html(target.data('description'))
                          .addClass('footer-flash--visible')
      }
    } else {
      $('.button--submit').addClass('button--disabled')
      $('.footer-flash').html("").removeClass('footer-flash--visible')
    }
  })
})
