class AssessmentNodesController < ApplicationController
  include HasAssessment
  skip_before_action :basic_auth, :verify_allowed_user

  def create
    raise "Unable to create to assessment node" unless assessment_node

    if !assessment.nodes.include?(node)
      assessment.nodes << node if node.terminal?
      assessment.referrals << node.referrals
    end

    redirect_to NextLocation.resolve(assessment, node)
  end

  def destroy
    last_nonterminal_node = assessment.non_terminal_nodes.last
    if assessment.assessment_nodes.last&.destroy
      redirect_to last_nonterminal_node
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
