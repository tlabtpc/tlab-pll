class CrossChecksController < ApplicationController
  include HasAssessment

  # defines simple :edit methods for each cross check step
  CrossCheck::STEPS.each { |step| define_method step, -> { cross_check } }

  skip_before_action :basic_auth, :verify_allowed_user
  before_action :require_assessment

  def next_step
    if cross_check_skipped? || cross_check_complete?
      redirect_to assessment_path(assessment)
    elsif cross_check.update(cross_check_params)
      redirect_to send("#{next_step_name}_cross_checks_path")
    else
      render params[:current_step]
    end
  end

  def previous_step
    if cross_check_starting?
      redirect_to assessment_referrals_path
    else
      redirect_to send("#{previous_step_name}_cross_checks_path")
    end
  end

  private

  def cross_check
    @cross_check ||= assessment.cross_check.presence || assessment.create_cross_check
  end

  def cross_check_params
    params.fetch(:cross_check, {}).permit(
      :perform_check,
      :details,
      :deadlines,
      :caseworker_name,
      :caseworker_phone,
      :caseworker_email,
      :caseworker_organization,
      :client_is_long_term,
      :client_is_homeless,
      :client_is_in_sf,
      :client_has_consulted_attorney,
      :support_level,
      action_items: []
    )
  end

  def cross_check_skipped?
    cross_check_starting? &&
      cross_check_params[:perform_check].to_i.zero?
  end

  def cross_check_starting?
    previous_step_name.nil?
  end

  def cross_check_complete?
    next_step_name.nil?
  end

  def next_step_name
    CrossCheck.next_step_for(params[:current_step])
  end

  def previous_step_name
    CrossCheck.previous_step_for(params[:current_step])
  end
end
