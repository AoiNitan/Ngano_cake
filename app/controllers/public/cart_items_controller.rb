class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @cart_item.item_id = params[:cart_item][:item_id]
    current_cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])

    if current_cart_item.present?
      current_cart_item.quantity += params[:cart_item][:quantity].to_i
      current_cart_item.save
      redirect_to cart_items_path
    else
      @cart_item.save
      redirect_to cart_items_path
    end
  end

  def index
  end

  def update
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

end
