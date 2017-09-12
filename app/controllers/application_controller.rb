class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception # Prevent CSRF attacks by raising an exception. For APIs, you may want to use :null_session instead.
  force_ssl if: -> { Feature.ssl? }
  before_action :basic_auth, :verify_allowed_user
  before_action :set_layout_modifiers

  respond_to :html

  rescue_from(StandardError) { |e| apologize_and_go_home(e) }
  rescue_from(ActiveRecord::RecordNotFound) { |e| apologize_and_go_home(e, warning: "Sorry we couldn't find that page. It may have been deleted because it is out of date. Use the tool to find a new referral.") }

  def basic_auth
    basic_auth_name, basic_auth_password = ENV.fetch("BASIC_AUTH", "").split(":")

    if basic_auth_name.present? && basic_auth_password.present?
      authenticate_or_request_with_http_basic(Rails.application.config.site_name) do |name, password|
        ActiveSupport::SecurityUtils.variable_size_secure_compare(name, basic_auth_name) &
          ActiveSupport::SecurityUtils.variable_size_secure_compare(password, basic_auth_password)
      end
    else
      true
    end
  end

  def allowed
    {}
  end

  def verify_allowed_user
    allowed_level = allowed.fetch(action_name.to_sym, :admin)

    allowed = case
      when current_user&.admin? then allowed_level.in? %i[admin member guest]
      when current_user.present? then allowed_level.in? %i[member guest]
      else allowed_level.in? %i[guest]
    end

    unless allowed
      session[:return_to_url] = request.url
      redirect_to new_sessions_path
    end
  end

  private

  def set_layout_modifiers
    @layout_modifiers = { container: [] }
  end

  def set_white_background
    @layout_modifiers[:container] << :white
  end

  def set_wide_card
    @layout_modifiers[:container] << :wide
  end

  def set_unpadded_card
    @layout_modifiers[:container] << :unpadded
  end

  def apologize_and_go_home(e, warning: "We're sorry, something went wrong. We're looking at it now! In the meantime, please try again.")
    if Rails.env.development?
      raise e
    else
      flash[:warn] = warning
      redirect_to root_path
    end
  end

  def resource_class
    controller_name.classify.constantize
  end
end
