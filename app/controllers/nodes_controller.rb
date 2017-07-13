class NodesController < ApplicationController
  include HasAssessment

  skip_before_action :basic_auth, :verify_allowed_user
  before_action :require_assessment, only: :show

  def show
    @node = Node.find(params[:id])
  end
end
