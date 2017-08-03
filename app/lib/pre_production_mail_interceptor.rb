class PreProductionMailInterceptor
  def self.delivering_email(message)
    message.subject = "to:[#{message.to}] cc:[#{message.cc}] bcc:[#{message.bcc}] #{message.subject}"
    message.to = ENV['MAIL_INTERCEPTOR_DESTINATION'] ||
      "projectlegallink@mailinator.com"
    message.bcc = nil
    message.cc = nil
  end
end