$(function() {
  $('body').on('keyup', '.cross-checks__textarea--required', function(e) {
    let target = $(e.target)
    if ($(e.target).val() != undefined) {
      $('.button--submit').removeClass('disabled')
      $('.footer-flash').html(target.data('description'))
                        .addClass('footer-flash--visible')
    } else {
      $('.button--submit').addClass('disabled')
      $('.footer-flash').html("").removeClass('footer-flash--visible')
    }
  })
})
