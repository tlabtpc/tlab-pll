class CrossChecksController < ApplicationController
  include HasAssessment

  # defines simple :edit methods for each cross check step
  CrossCheck::STEPS.each { |step| define_method step, -> { cross_check } }

  skip_before_action :basic_auth, :verify_allowed_user
  before_action :require_assessment

  def next_step
    if cross_check_skipped?
      redirect_to assessment_path(assessment)
    elsif cross_check.update(cross_check_params)
      redirect_to send("#{next_step_name}_cross_checks_path")
    else
      render params[:current_step]
    end
  end

  def previous_step
    redirect_to send("#{previous_step_name}_cross_checks_path")
  end

  def complete
  end

  private

  def cross_check
    @cross_check ||= assessment.cross_check.presence || assessment.create_cross_check
  end

  def cross_check_params
    params.fetch(:cross_check, {}).permit(
      :details,
      :deadlines,
      :caseworker_name,
      :caseworker_phone,
      :caseworker_email,
      :caseworker_organisation,
      :client_is_long_term,
      :client_is_homeless,
      :client_is_in_sf,
      :client_has_consulted_attorney,
      :support_level,
      :action_item_ids
    )
  end

  def cross_check_skipped?
    params[:current_step] == CrossCheck::STEPS.first &&
    !params.require(:cross_check).delete(:perform_check).to_i
  end

  def next_step_name
    CrossCheck.next_step_for(params[:current_step])
  end

  def previous_step_name
    CrossCheck.previous_step_for(params[:current_step])
  end
end
