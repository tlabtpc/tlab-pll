class PrimaryReferralsController < ApplicationController
  skip_before_action :basic_auth, :verify_allowed_user

  def show
    @primary_referral = PrimaryReferral.find(params[:id])
  end
end
