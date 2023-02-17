class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!


  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0){|sum, item| sum + item.subtotal }
  end

def update
    @order = Order.find(params[:id])
    @order.status = params[:order][:status]
    @order.status.update(order_params)
    @order_details = @order.order_details

  if @order.status == "payment_confirmation"
    @order_details.each do |order_detail|
      order_detail.making_status = "waiting"
      order_detail.save
    end
  end
    redirect_to request.referer
end


  private

  def order_params
    params.require(:order).permit(:status)
  end

end
