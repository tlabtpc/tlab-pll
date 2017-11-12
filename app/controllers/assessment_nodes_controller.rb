class AssessmentNodesController < ApplicationController
  include HasAssessment
  skip_before_action :basic_auth, :verify_allowed_user

  def create
    raise "Unable to create to assessment node" unless assessment_node

    assessment.transaction do
      if terminal_node_has_previously_been_submitted?
        assessment.nodes.destroy(assessment.nodes.last)
      end

      if !assessment.nodes.include?(node)
        if node.terminal?
          assessment.nodes << node
          assessment.update(has_terminal_node: true)
        end
        assessment.referrals << node.referrals
      end
    end

    redirect_to NextLocation.resolve(assessment, node)
  end

  def destroy
    if assessment.non_terminal_assessment_nodes.any?
      last_nonterminal_node = assessment.non_terminal_nodes.last
      assessment.terminal_assessment_nodes.last&.destroy
      assessment.non_terminal_assessment_nodes.last.destroy
      assessment.update(has_terminal_node: false)
      redirect_to last_nonterminal_node
    else
      assessment.destroy
      redirect_to new_assessment_path
    end
  end

  private

  def terminal_node_has_previously_been_submitted?
    assessment.nodes.last&.terminal?
  end

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
