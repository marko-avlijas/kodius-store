# == Schema Information
#
# Table name: promotion_codes
#
#  id          :bigint           not null, primary key
#  amount      :decimal(8, 2)    not null
#  can_combine :boolean          default(FALSE), not null
#  code        :string           not null
#  type        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class PromotionCode < ApplicationRecord
  validates :code, presence: true
  validates :type, presence: true, inclusion: { in: %w(PercentDiscount AmountDiscount) }
  validates :amount, numericality: { greater_than: 0 }

  has_and_belongs_to_many :baskets
end
