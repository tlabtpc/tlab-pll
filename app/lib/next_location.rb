NextLocation = Struct.new(:assessment, :node) do
  include Rails.application.routes.url_helpers

  def self.resolve(*args)
    new(*args).resolve
  end

  def resolve
    return resolve_for_terminal_node if node.terminal?

    node_path(node)
  end

  private

  def resolve_for_terminal_node
    if assessment.referrals.any?
      assessment_referrals_path
    else
      start_cross_checks_path
    end
  end
end
