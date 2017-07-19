class AssessmentsController < ApplicationController
  skip_before_action :basic_auth, :verify_allowed_user

  def show
    assessment.update(submitted_at: Time.current) unless assessment.submitted_at
  end

  def new
    @special_referrals = SpecialReferral.all
  end

  def create
    if cookies[:assessment] = Assessment.create(assessment_params).token
      redirect_to Node.root
    else
      raise "Could not create assessment"
    end
  end

  private

  def assessment
    @assessment ||= Assessment.find(params[:id]).decorate
  end

  def assessment_params
    params.fetch(:assessment, {}).permit(referral_ids: [])
  end
end
