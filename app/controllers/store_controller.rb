# -*- coding: utf-8 -*-
class StoreController < ApplicationController
  def index
    @products1 = Product.limit(3)
    @products2 = Product.offset(3).limit(5)
    @cart = current_cart
  end

  def akafilt
    if(params[:title] and 
          params[:producer] and
          params[:model] and
          params[:print_tech][:print_tech] and
          params[:color] and
          params[:compatibility] and
          (params[:title].length > 0 or
            params[:producer].length > 0 or
            params[:model].length > 0 or
            params[:print_tech][:print_tech].length > 0 or
            params[:color][:color].length > 0 or
            params[:compatibility].length > 0))
      @products = Product.where("title ~* ? and 
          producer ~* ? and
          model ~* ? and
          print_tech ~* ? and
          color ~* ? and
          compatibility ~* ?",params[:title].mb_chars.downcase,
          params[:producer].mb_chars.downcase,
          params[:model].mb_chars.downcase,
          params[:print_tech][:print_tech],
          params[:color][:color],
          params[:compatibility].mb_chars.downcase)
    elsif(params[:search] and params[:search].length > 0)
      @products = Product.search ('*'+params[:search]+'*')
    elsif(params[:producer] and
          #params[:category] and 
          params[:producer].length > 0)# and
          #params[:category].length > 0)
      @products = Product.find_all_by_producer(params[:producer])
    end
    @cart = current_cart
  end

  def view_cart
    @cart = current_cart
  end

  def about_product
    @cart = current_cart
    @product = Product.find(params[:id])
  end

  def information
    @cart = current_cart
  end

  def delivery
    @cart = current_cart
  end

  def vacancy
    @cart = current_cart
  end

  def contacts
    @cart = current_cart
  end

  def profile
    @cart = current_cart
    @orders = Order.find_all_by_user_id(current_user.id)
    #@line_items = LineItem.all
  end

  def sign_up
    @cart = current_cart
  end

  def advanced_search
    @cart = current_cart
    
  end
  def users
    @users = User.all
  end
  def order_print
    #@order = Order.find(params[:id])
    render :layout => 'layouts/order_print'

  end



  def my_templates
    @cart = current_cart
    @templates = Template.find_all_by_user_id(current_user.id)
  end
end
