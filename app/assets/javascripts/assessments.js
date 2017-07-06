$(function() {
  $('.assessments-new').on('change', '.assessments__checkbox.confirm', function() {
    allChecked = $('.assessments__checkbox.confirm').toArray().every(function(c) { return c.checked })
    $('.assessments__submit').prop('disabled', !allChecked)
    $('.assessments__next-button').toggleClass('disabled', !allChecked)
  })
})
