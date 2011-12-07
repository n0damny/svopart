# -*- coding: utf-8 -*-

class Order < ActiveRecord::Base 
  PAYMENT_TYPES = [ "Наличный расчёт", "Безналичный расчёт" ]
  STATUS_TYPES = [ "в обработке", "в доставке" , "выполнен", "отменён"]
  validates :name, :address, :email, :pay_type, :order_num, :status, :phone, :presence => true
  validates :phone, :numericality => true, :length => { :minimum => 10 }
  validates :pay_type, :inclusion => PAYMENT_TYPES
  has_many :line_items, :dependent => :destroy
  belongs_to :user


  define_index do
    indexes name
    indexes address
    indexes email
  end

  def duplicate(old)
    order_old = Order.find_by_id(old)
    order = Order.new
    order.name = order_old.name
    order.address = order_old.address
    order.email = order_old.email
    order.pay_type = order_old.pay_type
    order.user_id = order_old.user_id
    order.delivery = order_old.delivery
    order.phone = order_old.phone

    return order
  end
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
