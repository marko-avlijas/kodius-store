# == Schema Information
#
# Table name: credit_cards
#
#  id          :bigint           not null, primary key
#  cvv2        :integer          not null
#  expiry_date :date             not null
#  number      :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_credit_cards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class CreditCard < ApplicationRecord
  belongs_to :user

  validates :number, :expiry_date, presence: true
  validates :cvv2, numericality: { only_integer: true,
                                     greater_than_or_equal_to: 100,
                                     less_than: 1000 }
  validates :number, format: { with: /\A\d{4}\s{1}\d{4}\z/,
                               message: "must be in format: 1234 5678" }

  validate :expiry_date_must_be_after_tomorrow

  def expiry_date_must_be_after_tomorrow
    if expiry_date.present? && expiry_date < Date.tomorrow
      errors.add(:expiry_date, "must be in the future")
    end
  end
end
