$(function() {

  if ($('body').find('.square-collection').length) {
    $('.button--submit').addClass('button--disabled')
  }

  $('body').on('click', '.square', function(e) {
    var target = $(e.target)

    // ensure this is the only selected node
    $('.square').removeClass('square--selected')
    $('.square__icon').removeClass('hide')
    $('.square__icon--selected').addClass('hide')
    target.addClass('square--selected')
    target.find('.square__icon--selected').removeClass('hide')
    target.find('.square__icon').addClass('hide')


    // set the current square value input
    $('#square_value').val(target.data('value'))

    if (target.data('value') != null) {
      // enable the button if an id has been set
      $('.button--submit').prop('disabled', false).removeClass('button--disabled')
    } else {
      // otherwise, disable the button
      $('.button--submit').prop('disabled', true).addClass('button--disabled')
    }

    $('.footer-flash').removeClass('footer-flash--visible')

    if (target.data('description')) {
      function showFooterFlash(){
        $('.footer-flash').html(target.data('description'))
          .addClass('footer-flash--visible')
      }

      setTimeout(
        showFooterFlash, 200
      )
    }
  })
})
