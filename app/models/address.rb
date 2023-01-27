class Address < ApplicationRecord

  belongs_to :customer

  validates :name, presence: true
  validates :postal_code, presence: true, format: { with: VALID_POSTAL_CODE_REGEX }
  validates :address, presence: true

  def full_address
    "〒" + postal_code.to_s.insert(3, "-") + " " + address + "  " + name
  end

end
