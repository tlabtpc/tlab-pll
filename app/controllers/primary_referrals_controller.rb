class PrimaryReferralsController < ApplicationController
  skip_before_action :basic_auth, :verify_allowed_user
  before_action :set_white_background, only: :show
  before_action :set_wide_card, only: :show

  def show
    primary_referral
  end

  def send_email
    # TODO: put in queuing system to background emails
    PrimaryReferralsMailer.show(primary_referral, to: email_address).deliver_now
    flash[:info] = "Referral successfully sent to #{email_address}"
  rescue ActionController::ParameterMissing
    flash[:error] = "No email address provided"
  ensure
    redirect_to primary_referral_path(primary_referral)
  end

  private

  def email_address
    @email_address ||= params.require(:primary_referral).require(:email_address)
  end

  def primary_referral
    @primary_referral ||= Referral.featured.find(params[:id])
  end
end
