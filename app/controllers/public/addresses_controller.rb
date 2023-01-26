class Public::AddressesController < ApplicationController

  before_action :authenticate_customer!

  def create
    @address = current_customer.addresses.new(addresses_params)
    if @address.save
      @address = current_customer.addresses.all
    else
      @address = current_customer.address.all
      render :index
    end
  end

  def index
    @addresses = current_customer.addresses.all
    @address = Address.new
  end

  def edit
    @address = Adress.find(params[:id])
  end

  def update
    @address = current_customer.addresses.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :index
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    @addresses = current_customer.address.all
  end

  private

  def addresses_params
    params.require(:address).permit(:name, :posttal_code, :address)
  end

end
