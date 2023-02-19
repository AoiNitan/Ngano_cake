class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details
    @order_detail.making_status = params[:order_detail][:making_status].to_i
    @order_detail.update(order_detail_params)

    if @order_details.where(making_status: "making").count >= 1
      @order.status = "making"
      @order.save
    end

    if @order.order_details.count == @order_details.where(making_status: "completed").count
      @order.status = "shipping_preparation"
      @order.save
    end

    end
  end



  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
