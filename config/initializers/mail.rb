unless Rails.env.test? || ENV['DELIVER_EMAIL']
  ActionMailer::Base.register_interceptor(PreProductionMailInterceptor)
end