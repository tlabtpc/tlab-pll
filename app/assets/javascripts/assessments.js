$(function() {
  $('.assessments-new').on('change', '.assessments__checkbox--agree', function() {
    var allChecked = $('.assessments__checkbox--agree').toArray().every(function(c) { return c.checked })

    // enable the (hidden) submit button
    $('.assessments__submit').prop('disabled', !allChecked)

    // enable the next label
    $('.assessments__next-button').toggleClass('disabled', !allChecked)

    // show the special referrals panel
    $('.assessments__special-referrals').toggle(allChecked)
  })
})
