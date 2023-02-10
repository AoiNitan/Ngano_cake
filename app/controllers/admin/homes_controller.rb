class Admin::HomesController < ApplicationController
  before_action :move_to_signed_in

  def top
    @orders = Order.all.page(params[:page]).per(10).order(created_at: :desc)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def move_to_signed_in
    unless admin_signed_in?
      redirect_to root_path
    end
  end

end
