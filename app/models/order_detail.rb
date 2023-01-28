class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum making_status: {impossible: 0,waiting: 1,making: 2,completed: 3}

  validates :price, presence: true
  validates :amount, presence: true
  validates :making_status, presence: true


  def subtotal
    item.with_tax_price * amount
  end

end
