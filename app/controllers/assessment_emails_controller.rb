class AssessmentEmailsController < ApplicationController
  def create
    pp email_params
  end

  private

  def email_params
    params
      .require(:assessment_email)
      .permit(:address, :client_confirmation)
  end

  def allowed
    {
      create: :guest
    }
  end
end
