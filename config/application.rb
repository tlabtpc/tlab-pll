require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TlabPll
  class Application < Rails::Application
    config.action_controller.action_on_unpermitted_parameters = :raise

    # Project configuration
    config.site_name = "Project Legal Link"
    config.project_description = ""
  end
end
