class Feedback < ActionMailer::Base
  default :from => "info@svopart.ru"

  def send_feedback(sender)
    @sender = sender
    mail(:to => "info@svopart.ru", 
          :from => sender.email,
          :subject => "обратная связь")
  end
end
