# -*- coding: utf-8 -*-
class TemplatesController < ApplicationController
  # GET /templates
  # GET /templates.xml
  def index
    @templates = Template.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @templates }
    end
  end

  # GET /templates/1
  # GET /templates/1.xml
  def show
    @template = Template.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @template }
    end
  end

  # GET /templates/new
  # GET /templates/new.xml
  def new
    @template = Template.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @template }
    end
  end

  # GET /templates/1/edit
  def edit
    @template = Template.find(params[:id])
  end

  # POST /templates
  # POST /templates.xml
  def create
    
    @user = current_user
    if params[:order_id]
      order = Order.find(params[:order_id])
      order.line_items.each do |item|
        product = Product.find(item.product_id)
        #@template = @user.templates.build(:product => product)
        @template = @user.add_product(product.id)
        if !@template.save
          format.html { render :action => "new" }
          format.xml  { render :xml => @template.errors, :status => :unprocessable_entity }
        end
      end
    elsif params[:product_id]
      product = Product.find(params[:product_id])
      @template = @user.templates.build(:product => product)
      #@user.add_product(product.id)#Template.new(params[:template])
      if !@template.save
          format.html { render :action => "new" }
          format.xml  { render :xml => @template.errors, :status => :unprocessable_entity }
      end
    end
    respond_to do |format|
      #if @template.save
        format.html { redirect_to(:back, :notice => 'Шаблоны добавлены') }#redirect_to(@template
        format.xml  { render :xml => @template, :status => :created, :location => @template }
      #else
      #  format.html { render :action => "new" }
      #  format.xml  { render :xml => @template.errors, :status => :unprocessable_entity }
      #end
    end
  end

  # PUT /templates/1
  # PUT /templates/1.xml
  def update
    @template = Template.find(params[:id])

    respond_to do |format|
      if @template.update_attributes(params[:template])
        format.html { redirect_to(@template, :notice => 'Template was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.xml
  def destroy
    if params[:user_id]
      @templates = Template.find_all_by_user_id(params[:user_id])
      @templates.each do |template|
        template.destroy
      end
    else
    @template = Template.find(params[:id])
    @template.destroy
    end
    respond_to do |format|
      format.html { redirect_to(store_my_templates_url) }
      format.xml  { head :ok }
    end
  end
end
