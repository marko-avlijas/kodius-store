# == Schema Information
#
# Table name: baskets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Basket < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    line_item = line_items.find_by(product_id: product.id)
    if line_item
      line_item.update(quantity: line_item.quantity + 1)
    else
      line_items.create(product: product)
    end
  end
end
