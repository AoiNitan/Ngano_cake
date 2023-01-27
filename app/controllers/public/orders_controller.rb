class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    order.customer_id = current_customer.id

    cart_items = current_customer.cart_items
    @total = cart_items.inject(0) {|sum, item| sum + item.subtotal }
    order.charge = @total + params[:order][:shipping_cost].to_i

    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order_id = order.id
        order_detail.item_id = cart_item.item_id
        order_detail.price = cart_item.subtotal.to_s
        order_detail.amount = cart_item.amount
        order_detail.save
      end
      cart_items.destroy.all
      redirect_to complete_orders_path
    else
      redirect_to new_order_path
    end
  end

  def index
    @orders = current_customer.orders.all.order(created_at: :desc)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details
    @total_payment = @order_details.inject(0) { |sum, item| sum + item.subtotal}
  end

  def comfirm
    @order = Order.new

    @order.payment_method = params[:order][:payment_method]
    @order.shipping_cost = 800
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0){ |sum, item| sum + item.subtotal}
    @total_payment = @total + @order.shipping_cost

    if params[:order][:address_select] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.name
    elsif params[:order][:address_select] == "1"
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      @order.address = Address.find(params[:order][:address_id]).address
      @oreder.name = Address.find(params[:order][address_id]).name
    elsif params[:order][:address_select] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
    unless @order.postal_code == "" || @order.address == "" || @order.name == ""
      render :confirm
    else
      @order = Order.new
      @address = current_customer.addresses
      render :new
    end
  end

  def complete
  end



  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :price, :status, :shipping_cost)
  end

end
