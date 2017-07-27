class AssessmentDecorator < Draper::Decorator
  delegate_all

  def display_reference_id
    object.reference_id.gsub('-','')
  end

  def issue_description
    [
      category_name,
      include_in_summary_nodes.map{|n| "#{n.question}: #{n.title}"},
      sub_category_name
    ].flatten.join(', ')
  end

  def display_submitted_at
    object.submitted_at&.strftime('%m/%d/%y')
  end

  def county_name
    nodes.counties.pluck(:title).first
  end

  def category_name
    nodes.categories.pluck(:title).first
  end

  def sub_category_name
    terminal_nodes.pluck(:title).first
  end

  def caseworker_first_name
    cross_check.first_name
  end

  def caseworker_last_name
    cross_check.last_name
  end

  def caseworker_name
    [caseworker_first_name, caseworker_last_name].join ' '
  end

  def caseworker_phone
    cross_check.caseworker_phone
  end

  def caseworker_email
    cross_check.caseworker_email
  end

  def caseworker_organization
    cross_check.caseworker_organization
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
