function validatePrimaryReferralEmailForm() {
  var $form = $('#primary_referral_email_form');

  var $confirmationCheckbox = $form
    .find('#primary_referral_email_client_confirmation');

  var $addressField = $form.find('#primary_referral_email_address');

  function updatePrimaryReferralEmailButton() {
    var confirmed = Boolean($confirmationCheckbox.is(':checked'));
    var emailPresent = Boolean($addressField.val())
      && $addressField[0].checkValidity();

    var canSubmit = emailPresent && confirmed;

    $form.find('.button--submit').toggleClass('button--disabled', !canSubmit);
    $form.find('submit').attr('disabled', !canSubmit);
  }

  $confirmationCheckbox.change(updatePrimaryReferralEmailButton);
  $addressField[0].oninput = updatePrimaryReferralEmailButton;
}


$(function() {
  $('#send-email-modal').on('open.zf.reveal', validatePrimaryReferralEmailForm);
})
