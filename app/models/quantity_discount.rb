class QuantityDiscount < ApplicationRecord
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
