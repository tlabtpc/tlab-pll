$(function() {
  $('.nodes-show').on('click', '.nodes__child-list-item', function(e) {
    var target = $(e.target)
    $('.nodes__child-list-item').removeClass('nodes__child-list-item--selected')
    target.addClass('nodes__child-list-item--selected')

    $('.nodes__submit-button').prop('disabled', false)
    $('#node_id').val(target.data('id'))
    $('#node_description').val(target.data('description'))
  })
})
