class PromotionCode < ApplicationRecord
  validates :code, presence: true
  validates :type, presence: true, inclusion: { in: %w(PercentDiscount AmountDiscount) }
  validates :amount, numericality: { greater_than: 0 }
end
