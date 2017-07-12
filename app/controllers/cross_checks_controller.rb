class CrossChecksController < ApplicationController
  include HasAssessment

  # defines simple :edit methods for each cross check step
  CrossCheck::STEPS.each { |step| define_method step, -> { cross_check } }
  skip_before_action :basic_auth, :verify_allowed_user
  before_action :require_assessment, only: :show

  def next_step
    if cross_check.update(cross_check_params)
      redirect_to send :"#{next_step_name}_cross_checks_path"
    else
      render params[:current_step]
    end
  end

  def previous_step
    redirect_to send :"#{previous_step_name}_cross_checks_path"
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

  def next_step_name
    CrossCheck.next_step_for(params[:current_step])
  end

  def previous_step_name
    CrossCheck.previous_step_for(params[:current_step])
  end

  def current_step_index
    CrossCheck::STEPS.index(params[:current_step])
  end
end
