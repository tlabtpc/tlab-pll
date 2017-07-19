class CrossChecksController < ApplicationController
  include HasAssessment

  # defines simple :edit methods for each cross check step
  CrossCheck::STEPS.each { |step| define_method step, -> { cross_check } }

  skip_before_action :basic_auth, :verify_allowed_user
  before_action :require_assessment

  def next_step
    if cross_check_skipped? || cross_check_complete?
      redirect_to assessment_path(assessment)
    else
      cross_check.attributes = cross_check_params
      needs_email = cross_check.caseworker_email_changed?

      if cross_check.update(cross_check_params)
        if needs_email
          AssessmentsMailer.show(
            assessment,
            to: cross_check_params[:caseworker_email],
            cross_check: true
          ).deliver_now
        end

        redirect_to send("#{next_step_name}_cross_checks_path")
      else
        render params[:current_step]
      end
    end
  end

  def previous_step
    if cross_check_starting?
      redirect_to before_cross_check_path
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
      :first_name,
      :last_name,
      :caseworker_phone,
      :caseworker_email,
      :caseworker_organization,
      :client_is_long_term,
      :client_is_homeless,
      :client_is_in_sf,
      :client_has_consulted_attorney,
      :client_has_attorney_representation,
      :support_level,
      :county_node_id,
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
    cross_check.next_step_for(params[:current_step])
  end

  def previous_step_name
    cross_check.previous_step_for(params[:current_step])
  end

  def before_cross_check_path
    if assessment.featured_referrals.any?
      assessment_referrals_path
    else
      # destroy the terminal node and allow user to re-select
      # (this is the same as hitting 'back' on the assessment_referrals#index page)
      { controller: :assessment_nodes, action: :destroy }
    end
  end
end
