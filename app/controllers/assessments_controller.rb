class AssessmentsController < ApplicationController
  skip_before_action :basic_auth, :verify_allowed_user

  def show
    @assessment = Assessment.find(params[:id])
  end

  def new
  end

  def create
    if cookies[:assessment] = Assessment.create.token
      redirect_to Node.initial
    else
      raise "Could not create assessment"
    end
  end
end
