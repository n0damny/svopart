class Noteadmin < ActionMailer::Base
  default :from => 'Магазин картриджей Свопарт <info@svopart.ru>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.noteadmin.order_received_adm.subject
  #
  def order_received_adm(order)
    @order = order

    mail :to => "info@svopart.ru", :subject => "Новый заказ #{order.order_num}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.noteadmin.order_changed_adm.subject
  #
  def order_changed_adm(order)
    @greeting = "Hi"

    mail :to => 'info@svopart.ru'
  end
end
