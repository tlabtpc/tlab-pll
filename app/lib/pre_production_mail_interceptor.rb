class PreProductionMailInterceptor
  def self.delivering_email(message)
    message.subject = "[#{message.to}] #{message.subject}"
    message.to = ENV['MAIL_INTERCEPTOR_DESTINATION'] ||
      "projectlegallink@mailinator.com"
  end
end