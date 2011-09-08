ActionMailer::Base.default_url_options[:host] = "svopart.ru"
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address => "smtp.locum.ru",
    :port => 2525,
    :domain => "svopart.ru",
    :authentication => :plain,
    :user_name => "info@svopart.ru",
    :password => "cdjgfhn1",
    :enable_starttls_auto => false
}
#ActionMailer::Base.raise_delivery_errors = true



#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?


