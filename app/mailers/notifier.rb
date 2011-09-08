class Notifier < ActionMailer::Base
  default :from => 'Магазин картриджей Свопарт <info@svopart.ru>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    @order = order

    mail :to => order.email, :subject => 'Ваш заказ в магазине Свопарт'
  end


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    @order = order

    mail :to => order.email, :subject => 'Ваш заказ отправлен из магазина Свопарт'
  end
end
