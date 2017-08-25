class CrossCheckDecorator < Draper::Decorator
  delegate_all

  def reference_id
    object.assessment.reference_id
  end

  def county
    object.assessment.nodes.find_by(is_county: true)&.title
  end

  def home_county
    if object.client_is_in_issue_county
      county
    else
      object.county_node.title
    end
  end

  def category
    object.assessment.nodes.find_by(is_category: true)&.title
  end

  def subcategory
    object.assessment.nodes[4].title if category == 'Benefits'
  end

  def action_items
    object.action_items.join(', ').presence || 'None'
  end

  def primary_referral_titles
    object.assessment.primary_referrals.map(&:title).join(', ')
  end

  def client_has_consulted_attorney
    case object.client_has_consulted_attorney
    when "consulted_yes"         then "Yes"
    when "consulted_no"          then "No"
    when "consulted_i_dont_know" then "I don't know"
    end
  end

  def client_is_long_term
    case object.client_is_long_term
    when "yes"         then "Yes"
    when "no"          then "No"
    when "i_dont_know" then "I don't know"
    end
  end

  def support_level
    object.support_level.humanize
  end

  def client_has_attorney_representation
    case object.client_has_consulted_attorney
    when "consulted_yes"         then "Yes"
    when "consulted_no"          then "No"
    when "consulted_i_dont_know" then "I don't know"
    end
  end

end
