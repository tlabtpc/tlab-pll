class CrossChecksController < ApplicationController
  include HasAssessment
  # defines simple :edit methods for each cross check step
  CrossCheck::STEPS.each { |step| define_method step, -> { cross_check } }

  def new
    cross_check
  end

  def next_step
    if cross_check.update(cross_check_params)
      redirect_to send :"#{next_step_name}_cross_check_path"
    else
      render
    end
  end

  def previous_step
    redirect_to send :"#{previous_step_name}_cross_check_path"
  end

  def complete
  end

  private

  def cross_check
    @cross_check ||= assessment.cross_check.presence || assessment.create_cross_check
  end

  def cross_check_params
    params.require(:cross_check).permit(
      :current_step,
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
    CrossCheck::STEPS.fetch CrossCheck::STEPS.index(current_step_index+1), :complete
  end

  def prev_step_name
    CrossCheck::STEPS.fetch CrossCheck::STEPS.index(current_step_index-1), :new
  end

  def current_step_index
    CrossCheck::STEPS.index(cross_check_params[:current_step])
  end
end
