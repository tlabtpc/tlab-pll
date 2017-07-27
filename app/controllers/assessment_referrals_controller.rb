class AssessmentReferralsController < ApplicationController
  include HasAssessment

  skip_before_action :basic_auth, :verify_allowed_user
  before_action :require_assessment, only: :index

  def index
    @special_referrals = SpecialReferral.all
  end

  def update
    puts '*'*89
    puts params
    puts '*'*89

    redirect_to start_cross_checks_path
  end
end
