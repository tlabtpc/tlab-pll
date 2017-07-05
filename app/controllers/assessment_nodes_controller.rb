class AssessmentNodesController < ApplicationController
  include HasAssessment
  skip_before_action :basic_auth, :verify_allowed_user

  def create
    if AssessmentNode.create(assessment: assessment, node: node.parent_node)
      redirect_to node
    else
      raise "Unable to create to assessment node"
    end
  end

  def destroy
    if assessment_node = assessment.assessment_nodes.last
      redirect_to assessment_node.tap(&:destroy).node
    else
      redirect_to new_assessment_path
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
