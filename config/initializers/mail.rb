unless Rails.env.test? || ENV['DELIVER_EMAIL']
  ActionMailer::Base.register_interceptor(PreProductionMailInterceptor)
end

url_host = ENV['MAILER_URL_HOST']

if Rails.env.production? && url_host.blank?
  raise "Please set ENV['MAILER_URL_HOST'] so email links will work correctly"
end

url_options = {
  host: url_host || "localhost:3000"
}

Rails.application.routes.default_url_options = url_options
Rails.configuration.action_controller.default_url_options = url_options
