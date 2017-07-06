$(function() {
  $('.nodes-show').on('click', '.nodes__child-list-item', function(e) {
    let target = $(e.target)

    // ensure this is the only selected node
    $('.nodes__child-list-item').removeClass('nodes__child-list-item--selected')
    target.addClass('nodes__child-list-item--selected')

    // set the current node in the submit form to the selected id
    $('#node_id').val(target.data('id'))

    if (target.data('description')) {
      // display description if it exists
      $('.nodes__footer-flash').html(target.data('description'))
                               .addClass('nodes__footer-flash--visible')
    } else {
      // otherwise, hide the flash element
      $('.nodes__footer-flash').removeClass('nodes__footer-flash--visible')
    }
  })
})
