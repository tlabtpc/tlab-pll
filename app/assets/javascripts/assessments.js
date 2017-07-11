$(function() {
  $('.assessments-new').on('change', '.assessments__checkbox.confirm', function() {
    var allChecked = $('.assessments__checkbox.confirm').toArray().every(function(c) { return c.checked })

    // enable the (hidden) submit button
    $('#assessment_submit').prop('disabled', !allChecked)

    // enable the next label
    $('.assessments__next-button').toggleClass('disabled', !allChecked)

    // show the special referrals panel
    $('.assessments__special-referrals').toggle(allChecked)
  })
})
