# == Schema Information
#
# Table name: baskets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Basket < ApplicationRecord
  include PriceCalculation

  has_many :line_items, dependent: :destroy
  has_and_belongs_to_many :promotion_codes

  def add_product(product)
    line_item = line_items.find_by(product_id: product.id)
    if line_item
      line_item.update(quantity: line_item.quantity + 1)
    else
      line_items.create(product_id: product.id)
    end
  end
end
