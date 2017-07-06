$(function() {
  $('.assessments-new').on('change', '.assessments__checkbox', function() {
    allChecked = $('.assessments__checkbox').toArray().every(function(c) { return c.checked })
    $('.assessments__next-button').prop('disabled', !allChecked)
  })
})
