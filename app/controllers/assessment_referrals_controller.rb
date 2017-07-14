class AssessmentReferralsController < ApplicationController
  include HasAssessment

  skip_before_action :basic_auth, :verify_allowed_user
  before_action :require_assessment, only: :index

  def index
    @special_referrals = SpecialReferral.all
  end
end
