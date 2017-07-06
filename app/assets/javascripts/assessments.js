$(function() {
  $('.assessments-new').on('change', '.assessments__checkbox.confirm', function() {
    allChecked = $('.assessments__checkbox.confirm').toArray().every(function(c) { return c.checked })
    $('.assessments__next-button').prop('disabled', !allChecked)
  })
})
