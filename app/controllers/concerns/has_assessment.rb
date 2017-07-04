module HasAssessment
  extend ActiveSupport::Concern

  included { before_action :fetch_assessment }

  private

  def fetch_assessment
    @assessment ||= Assessment.find_by(token: assessment_token) if assessment_token.present?
  end

  def assessment_token
    @assessment_param ||= params[:assessment] || cookies[:assessment]
  end
end
