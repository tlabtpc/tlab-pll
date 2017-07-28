class AssessmentReferralsController < ApplicationController
  include HasAssessment

  skip_before_action :basic_auth, :verify_allowed_user
  before_action :require_assessment, only: :index

  def index
    @special_referrals = SpecialReferral.all
  end

  def update
    if params[:assessment_referrals].present?
      assessment_referral_params.each do |id, attrs|
        AssessmentReferral.find(id).update_attributes(attrs)
      end
    end

    redirect_to start_cross_checks_path
  end

  private

  def assessment_referral_params
    params.require(:assessment_referrals).permit!
  end
end
