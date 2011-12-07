# -*- coding: utf-8 -*-
class SupportsController < ApplicationController
  def new
    @cart = current_cart
    # id is required to deal with form
    @support = Support.new(:id => 1)
  end
 
  def create
    @support = Support.new(params[:support])
    if @support.save
      redirect_to('/', :notice => "Письмо отправлено.")
    else
      flash[:alert] = "Вы должны заполнить все поля."
      render 'new'
    end
  end
end
