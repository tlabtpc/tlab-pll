class PrimaryReferralsController < ApplicationController
  include HasAssessment
  skip_before_action :basic_auth, :verify_allowed_user

  def show
    @primary_referral = PrimaryReferral.find(params[:id])
  end

  def index
    redirect_to start_cross_checks_path if assessment.primary_referrals.empty?
  end
end
