class CrossChecksController < ApplicationController
  include HasAssessment

  # defines simple :edit methods for each cross check step
  CrossCheck::STEPS.each { |step| define_method step, -> { cross_check } }

  skip_before_action :basic_auth, :verify_allowed_user
  before_action :require_assessment

  def next_step
    if cross_check_skipped?
      redirect_to assessment_path(assessment.id)
    else
      cross_check.attributes = cross_check_params
      cookies[:previous_assessment] = cross_check.assessment.token if cross_check.remember_my_info
      needs_email = cross_check.caseworker_email_changed?

      if cross_check.update(cross_check_params)
        AssessmentsMailer.show(
          assessment,
          to: cross_check_params[:caseworker_email],
          cross_check: true
        ).deliver_now if needs_email

        if cross_check_complete?
          redirect_to assessment_path(assessment.id)
        else
          redirect_to send("#{next_step_name}_cross_checks_path")
        end
      else
        render params[:current_step]
      end
    end
  end

  def previous_step
    redirect_to send("#{previous_step_name}_cross_checks_path")
  end

  private

  def cross_check
    @cross_check ||= assessment.cross_check.presence || assessment.create_cross_check.tap do |cc|
      cc.update(previous_cross_check.as_json.slice(*CrossCheck::SAVED)) if previous_cross_check
    end
  end

  def previous_cross_check
    @previous ||= Assessment.find_by(token: cookies[:previous_assessment])&.cross_check
  end

  def cross_check_params
    params.fetch(:cross_check, {}).permit(
      :perform_check,
      :remember_my_info,
      :details,
      :deadlines,
      :first_name,
      :last_name,
      :caseworker_phone,
      :caseworker_email,
      :caseworker_organization,
      :client_is_long_term,
      :client_is_homeless,
      :client_is_in_issue_county,
      :client_has_consulted_attorney,
      :client_has_attorney_representation,
      :county_node_id,
      action_items: []
    )
  end

  def cross_check_skipped?
    params[:current_step] == 'start' &&
    cross_check_params[:perform_check].to_i.zero?
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
end
