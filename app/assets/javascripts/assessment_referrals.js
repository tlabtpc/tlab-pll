$(function() {
  var $submit = $('#assessment-referrals-submit');
  var $form = $('#assessment-referrals-form');

  if ($submit.length < 1 || $form.length < 1) { return }

  $submit.click(function() {
    $form.submit();
  });
});
