class AssessmentNodesController < ApplicationController
  include HasAssessment
  skip_before_action :basic_auth, :verify_allowed_user

  def create
    if AssessmentNode.new(assessment: assessment, node: node.parent_node).save
      redirect_to node
    else
      raise "Unable to create to assessment node"
    end
  end

  private

  def node
    @node ||= Node.find(assessment_node_params[:node_id])
  end

  def assessment_node_params
    params.require(:assessment_node).permit(:node_id)
  end
end
