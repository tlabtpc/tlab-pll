class AssessmentDecorator < Draper::Decorator
  delegate_all

  def display_reference_id
    object.reference_id.gsub('-','')
  end

  def county_name
    nodes.counties.pluck(:title).first
  end

  def category_name
    nodes.categories.pluck(:title).first
  end

  def caseworker_first_name
    cross_check.first_name
  end

  def details
    cross_check.details
  end

  def action_items
    cross_check.action_items
  end

  def deadlines
    cross_check.deadlines
  end

  def attorney_status
    case cross_check.client_has_consulted_attorney
    when 'yes' then 'Has consulted'
    when 'no'  then 'Has not consulted'
    when 'i_dont_know' then 'Unknown'
    end
  end

  private

  def cross_check
    object.cross_check || CrossCheck.new # TODO maybe need a nullobj pattern here?
  end

  def nodes
    @nodes ||= object.nodes
  end
end
