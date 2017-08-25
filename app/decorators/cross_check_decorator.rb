class CrossCheckDecorator < Draper::Decorator
  delegate_all

  def reference_id
    object.assessment&.reference_id
  end

  def county
    nodes.find_by(is_county: true)&.title
  end

  def home_county
    if object.client_is_in_issue_county
      county
    else
      object.county_node&.title
    end
  end

  def category
    nodes.find_by(is_category: true)&.title
  end

  def subcategory
    nodes[4]&.title
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

  def client_is_homeless
    if object.client_is_homeless then 'Yes' else 'No' end
  end

  def created_at_date
    object.created_at.to_date
  end

  def created_at_time
    object.created_at.strftime('%H:%M %P')
  end

  def support_level
    object.support_level.to_s.humanize
  end

  def client_has_attorney_representation
    case object.client_has_consulted_attorney
    when "consulted_yes"         then "Yes"
    when "consulted_no"          then "No"
    when "consulted_i_dont_know" then "I don't know"
    end
  end

  def nodes
    @nodes ||= object.assessment&.nodes || Node.none
  end

end
