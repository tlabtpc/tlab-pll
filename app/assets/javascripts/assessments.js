$(function() {
  $('.assessments-new').on('change', '.assessments__checkbox-input', function() {
    var allChecked = $('.assessments__checkbox-input').toArray().every(function(c) { return c.checked })

    // enable the (hidden) submit button
    $('#assessment_submit').prop('disabled', !allChecked)

    // enable the next label
    $('.button--submit').toggleClass('disabled', !allChecked)

    // show the special referrals panel
    $('.assessments__special-referrals').toggle(allChecked)
  })
})
