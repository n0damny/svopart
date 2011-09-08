class OrdersController < ApplicationController
  load_resource :except => [:index, :user_order_line_items, :order_print]
  authorize_resource :except => [:user_order_line_items]

  def order_print
    #@order = Order.find(params[:id])
    render :layout=>false  
  end
  
  # GET /orders
  # GET /orders.xml
  def index
    if current_user
      @orders = Order.paginate :page=>params[:page], :order=>'created_at desc', 
                :per_page => 10
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @orders }
      end
    else
      redirect_to root_path, :notice => "не получишь, не получишь"
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    #@order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to root_path, :notice => "Ваша корзина пуста"
      return
    end

    #@order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    #@order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    if params[:order_id]
      #@order_old = Order.find(params[:order_id])
      @order = @order.duplicate(params[:order_id])
      @order.order_num = Time.now.strftime("%y%m%d").to_s + Order.find_by_sql("select (count(*) + 1) as cn from orders o where to_char(o.created_at,'yyyy-mm-dd') = to_char(current_date,'yyyy-mm-dd')").first.cn.to_s
    else
      if params[:order][:deliv_type] == 'самовывоз'
        @order.address = 'none'
      end
      #@order = Order.new(params[:order])
      @order.order_num = Time.now.strftime("%y%m%d").to_s + Order.find_by_sql("select (count(*) + 1) as cn from orders o where to_char(o.created_at,'yyyy-mm-dd') = to_char(current_date,'yyyy-mm-dd')").first.cn.to_s
      @order.add_line_items_from_cart(current_cart)
    end
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id]) 
        session[:cart_id] = nil
        Notifier.order_received(@order).deliver
        format.html { redirect_to(root_path, :notice =>'Благодарим за ваш заказ. Оператор свяжется с вами для подтверждения деталей.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    #@order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Заказ успешно изменён.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    #@order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end
