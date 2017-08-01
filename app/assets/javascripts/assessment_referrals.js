function AssessmentReferrals() {
  var $primaryReferrals = $('.assessment-referrals__primary-referral');

  $primaryReferrals.each(function(i, referralEl) {
    var $referral = $(referralEl);

    checkUsefulRadio($referral);
    listenForUsefulChange($referral);
  });
}

function checkUsefulRadio($referral) {
  var useful = $referral.data('useful');

  if (isBoolean(useful)) {
    var val = useful.toString();

    $referral
      .find('.assessment-referrals__usefulness-checkbox[value=true]')
      .prop('checked', useful);

    $referral
      .find('.assessment-referrals__usefulness-checkbox[value=false]')
      .prop('checked', !useful);
  }
}

function listenForUsefulChange($referral) {
  $referral.on('change', function(e) {
    var newVal = $(e.target).val();
    var id = $referral.data('assessment-referral-id');

    updateUsefulness(newVal, id);
  })
}

function updateUsefulness(newVal, id) {
  var url = $('.assessment-referrals')
    .data('update-path')
    .replace(/0/, id);

  return $.ajax({
    url: url,
    method: 'PUT',
    data: { assessment_referral: { useful: newVal } }
  })
}

function isBoolean(val) {
  return typeof val === 'boolean'
}

$(AssessmentReferrals);
