class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :authenticate_user!, :except => [:some_action_without_auth]
  

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      flash[:error] = "мимо"    
      redirect_to root_path
    else
      flash[:error] = "Невозможно произвести эту операцию не авторизовавшись."
      authenticate_user!
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to("/404.html")
  end

  private
  
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

end
