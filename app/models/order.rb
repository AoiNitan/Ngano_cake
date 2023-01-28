class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details


  enum payment_method: {credit_card: 0,transfer: 1}
  enum status: {waiting: 0,payment_confirmation: 1,making: 2,shipping_preparation: 3,shipped: 4}

  validates :customer_id, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :shipping_cost, presence: true
  validates :total_payment, presence: true


  def subtotal
    item.with_tax_price * order_detail.amount
  end

  def total_amount
    self.order_amounts.all.sum(:amount)
  end

end
