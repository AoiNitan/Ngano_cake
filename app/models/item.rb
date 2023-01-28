class Item < ApplicationRecord
  has_one_attached :image

  has_many :cart_items
  has_many :order_details
  has_many :orders, through: :order_details
  belongs_to :genre

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  def with_tax_price
    (price * 1.1).floor
  end
end
