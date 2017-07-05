$(function() {
  $('.nodes-show').on('click', '.nodes__child-list-item', function(e) {
    let target = $(e.target)
    $('.nodes__child-list-item').removeClass('nodes__child-list-item--selected')
    target.addClass('nodes__child-list-item--selected')
    $('#node_id').val(target.data('id'))
    $('#node_description').val(target.data('description'))
  })
})
