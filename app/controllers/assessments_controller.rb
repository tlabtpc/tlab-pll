class AssessmentsController < ApplicationController
  skip_before_action :basic_auth, :verify_allowed_user
  before_action :set_white_background, only: :show
  before_action :set_wide_card, only: :new
  before_action :set_unpadded_card, only: :show

  def show
    assessment.update(submitted_at: Time.current) unless assessment.submitted_at
  end

  def new
    @special_referrals = SpecialReferral.all
  end

  def send_email
    AssessmentsMailer.show(assessment, to: email_address).deliver_now
    flash[:info] = "Summary successfully sent to #{email_address}"
  rescue ActionController::ParameterMissing
    flash[:error] = "No email address provided"
  ensure
    redirect_to assessment_path(assessment)
  end

  def create
    if cookies[:assessment] = Assessment.create(assessment_params).token
      redirect_to Node.root
    else
      raise "Could not create assessment"
    end
  end

  private

  def email_address
    @email_address ||= params.require(:assessment).require(:email_address)
  end

  def assessment
    @assessment ||= Assessment.find(params[:id]).decorate
  end

  def assessment_params
    params.fetch(:assessment, {}).permit(referral_ids: [])
  end
end
