class Public::AddressesController < ApplicationController

  def create
    @address = current_customer.addresses.new(addresses_params)
    if @address.save
      @address = current_customer.addresses.all
    else
      @address = current_customer.address.all
      render :error
    end
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def addresses_params
    params.require(:address).permit(:name, :posttal_code, :address)
  end

end
