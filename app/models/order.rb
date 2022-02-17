# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  include PriceCalculation

  belongs_to :user
  has_many :line_items
  has_and_belongs_to_many :promotion_codes

  def transfer_line_items_and_promotions_from_basket(basket)
    basket.line_items.each do |line_item|
      line_item.basket_id = nil
      line_items << line_item
    end

    basket.promotion_codes.each do |promo_code|
      promotion_codes << promo_code
    end

    save
  end
end
