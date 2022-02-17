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
  has_and_belongs_to_many :promotion_codes

  def add_product(product)
    line_item = line_items.find_by(product_id: product.id)
    if line_item
      line_item.update(quantity: line_item.quantity + 1)
    else
      line_items.create(product_id: product.id, type: "ProductLineItem")
    end
  end

  def add_product_bundle(product_bundle)
    line_item = line_items.find_by(product_bundle_id: product_bundle.id)
    if line_item
      line_item.update(quantity: line_item.quantity + 1)
    else
      line_items.create(product_bundle_id: product_bundle.id, type: "BundleLineItem")
    end
  end

  def total_before_promotions
    @total_before_promotions ||= line_items.to_a.sum { |item| item.total_price }
  end

  def total
    @total ||= total_before_promotions +
               promotion_codes.to_a.sum { |code| code.apply_to(total_before_promotions) }
  end
end
