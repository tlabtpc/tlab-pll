function validateEmailForm(prefix) {
  var $form = $('#' + prefix + '_email_form');

  var $confirmationCheckbox = $form
    .find('#' + prefix + '_email_client_confirmation');

  var $addressField = $form.find('#' + prefix + '_email_address');

  function updateEmailButton() {
    var confirmed = Boolean($confirmationCheckbox.is(':checked'));
    var emailPresent = Boolean($addressField.val())
      && $addressField[0].checkValidity();

    var canSubmit = emailPresent && confirmed;

    $form.find('.button--submit').toggleClass('button--disabled', !canSubmit);
    $form.find('submit').attr('disabled', !canSubmit);
  }

  $confirmationCheckbox.change(updateEmailButton);
  $addressField[0].oninput = updateEmailButton;
}

function validatePrimaryReferralEmailForm() {
  return validateEmailForm("primary_referral");
}

function validateAssessmentEmailForm() {
  return validateEmailForm("assessment");
}

$(function() {
  $('#send-referral-email-modal')
    .on('open.zf.reveal', validatePrimaryReferralEmailForm)

  $('#send-assessment-email-modal')
    .on('open.zf.reveal', validateAssessmentEmailForm)

  $('#print').on('click', function() { window.print() })
})
