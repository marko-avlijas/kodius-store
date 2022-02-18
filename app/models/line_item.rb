# == Schema Information
#
# Table name: line_items
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(1), not null
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  basket_id  :bigint
#  order_id   :bigint
#  product_id :bigint
#
# Indexes
#
#  index_line_items_on_basket_id   (basket_id)
#  index_line_items_on_order_id    (order_id)
#  index_line_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (basket_id => baskets.id)
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
class LineItem < ApplicationRecord
  belongs_to :basket, optional: true
  belongs_to :order, optional: true
  belongs_to :product

  delegate :name, to: :product

  def price_per_unit
    product.price
  end

  def total_price
    discount = product.quantity_discount

    if discount.blank?
      price_per_unit * quantity 
    else
      discounted_quantity = (quantity / discount.quantity).to_i
      full_price_quantity = quantity % discount.quantity

      discount.price * discounted_quantity + full_price_quantity * price_per_unit
    end
  end
end
