class CrossCheck < ApplicationRecord
  STEPS = %w(
    start
    details
    info
    deadlines
    residence
    county_select
    consulted
    representation
    actions
    support
  ).freeze

  SAVED = %w(
    first_name
    last_name
    caseworker_email
    caseworker_phone
    caseworker_organization
  )

  belongs_to :assessment, required: true
  belongs_to :county_node, class_name: 'Node'

  enum client_is_long_term: %w(yes no i_dont_know).freeze

  enum client_has_attorney_representation: %w(
    representation_yes
    representation_no
    representation_i_dont_know
  ).freeze

  enum client_has_consulted_attorney: %w(
    consulted_yes
    consulted_no
    consulted_i_dont_know
  )

  enum support_level: %w(low medium high).freeze

  attr_accessor :perform_check

  def previous_step_for(action_name)
    unless action_name.to_s == STEPS.first
      valid_steps[current_step_index(action_name) - 1]
    end
  end

  def next_step_for(action_name)
    valid_steps[current_step_index(action_name) + 1]
  end

  private

  def valid_steps
    STEPS
      .map { |step| step_valid?(step) ? step : nil }
      .compact
  end

  def current_step_index(action_name)
    valid_steps.index(action_name.to_s).tap do |index|
      raise ArgumentError.new("Cannot find step named #{action_name}") if index.nil?
    end
  end

  def issue_county_unknown?
    Assessment.find(assessment_id).nodes.where(code: '55e4fc7107115758').present?
  end

  def step_valid?(action_name)
    case action_name.to_s
    when 'residence'
      !issue_county_unknown?
    when 'county_select'
      !client_is_in_issue_county?
    when 'representation'
      consulted_yes?
    else
      true
    end
  end
end
