class AssessmentsController < ApplicationController
  skip_before_action :basic_auth, :verify_allowed_user

  def show
    @assessment = Assessment.find(params[:id])
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

  def assessment_params
    params.fetch(:assessment, {}).permit(referral_ids: [])
  end
end
