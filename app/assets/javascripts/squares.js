$(function() {

  if ($('body').find('.square-collection')) {
    $('.button--submit').addClass('disabled')
  }

  $('body').on('click', '.square', function(e) {
    var target = $(e.target)

    // ensure this is the only selected node
    $('.square').removeClass('square--selected')
    target.addClass('square--selected')

    // set the current square value input
    $('#square_value').val(target.data('value'))

    if (target.data('value') != undefined) {
      // enable the button if an id has been set
      $('.button--submit').prop('disabled', false).removeClass('disabled')
    } else {
      // otherwise, disable the button
      $('.button--submit').prop('disabled', true).addClass('disabled')
    }

    if (target.data('description')) {
      // display description if it exists
      $('.footer-flash').html(target.data('description'))
                        .addClass('footer-flash--visible')
    } else {
      // otherwise, hide the flash element
      $('.footer-flash').removeClass('footer-flash--visible')
    }
  })
})
