class PrimaryReferralsController < ApplicationController
  skip_before_action :basic_auth, :verify_allowed_user
  before_action :set_white_background, only: :show
  before_action :set_unpadded_card, only: :show

  def show
    primary_referral
  end

  def send_email
    render_spanish = primary_referral_params[:email_language] == "Spanish"
    PrimaryReferralsMailer.show(primary_referral, render_spanish, to: email_address).deliver_now
    flash[:info] = "Referral successfully sent to #{email_address} in #{primary_referral_params[:email_language]}"
  rescue ActionController::ParameterMissing
    flash[:error] = "No email address provided"
  ensure
    redirect_to primary_referral_path(primary_referral)
  end

  private

  def primary_referral_params
    params.require(:primary_referral).permit(:email_language, :email_address, :client_confirmation)
  end

  def email_address
    @email_address ||= primary_referral_params[:email_address]
  end

  def primary_referral
    @primary_referral ||= Referral.featured.find(params[:id])
  end
end
