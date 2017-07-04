module HasAssessment
  private

  def assessment
    @assessment ||= Assessment.find_by(token: assessment_token) if assessment_token.present?
  end

  def assessment_token
    @assessment_token ||= params[:assessment] || cookies[:assessment]
  end
end
