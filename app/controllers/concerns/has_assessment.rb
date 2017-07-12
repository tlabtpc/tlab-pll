module HasAssessment
  private

  def assessment
    if assessment_token.present?
      @assessment ||= Assessment.find_by(token: assessment_token)
    end
  end

  def assessment_token
    @assessment_token ||= params[:assessment] || cookies[:assessment]
  end

  def require_assessment
    return if assessment.present?
    flash[:notice] = "Sorry, we couldn't find your current assessment. Please create a new one"
    redirect_to new_assessment_path
  end
end
