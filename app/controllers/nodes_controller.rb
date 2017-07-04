class NodesController < ApplicationController
  skip_before_action :basic_auth, :verify_allowed_user
  before_action :require_assessment

  def show
    @node = Node.find(params[:id])
    redirect_to @assessment if @assessment.terminate_with!(@node)
  end

  private

  def require_assessment
    return if @assessment = Assessment.find_by(token: params[:assessment] || cookies[:assessment])
    flash[:notice] = "Sorry, we couldn't find your current assessment. Please create a new one"
    redirect_to new_assessments_path
  end
end
