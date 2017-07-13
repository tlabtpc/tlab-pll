class AssessmentNodesController < ApplicationController
  include HasAssessment
  skip_before_action :basic_auth, :verify_allowed_user

  def create
    unless assessment_node
      raise "Unable to create to assessment node"
    end

    unless assessment.nodes.include?(node)
      if node.terminal?
        assessment.nodes << node
      end

      assessment.referrals << node.referrals
    end

    redirect_to NextLocation.resolve(assessment, node)
  end

  def destroy
    if assessment_node = assessment.assessment_nodes.last
      redirect_to assessment_node.tap(&:destroy).node
    else
      assessment.destroy
      redirect_to new_assessment_path
    end
  end

  private

  def assessment_node
    @assessment_node ||= AssessmentNode.find_or_create_by \
      assessment: assessment,
      node: node.parent_node
  end

  def node
    @node ||= Node.find(assessment_node_params[:node_id])
  end

  def assessment_node_params
    params.require(:assessment_node).permit(:node_id)
  end
end
