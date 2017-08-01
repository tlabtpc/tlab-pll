class AssessmentReferralsController < ApplicationController
  include HasAssessment

  skip_before_action :basic_auth, :verify_allowed_user
  before_action :require_assessment, only: :index

  def index
    @special_referrals = SpecialReferral.all
  end

  def update
    AssessmentReferral
      .find(params[:id])
      .update_attributes(assessment_referral_params)
  end

  private

  def assessment_referral_params
    params.require(:assessment_referral).permit(:useful)
  end
end
