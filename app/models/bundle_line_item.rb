# == Schema Information
#
# Table name: line_items
#
#  id                :bigint           not null, primary key
#  quantity          :integer          default(1), not null
#  type              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  basket_id         :bigint
#  order_id          :bigint
#  product_bundle_id :bigint
#  product_id        :bigint
#
# Indexes
#
#  index_line_items_on_basket_id          (basket_id)
#  index_line_items_on_order_id           (order_id)
#  index_line_items_on_product_bundle_id  (product_bundle_id)
#  index_line_items_on_product_id         (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (basket_id => baskets.id)
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_bundle_id => product_bundles.id)
#  fk_rails_...  (product_id => products.id)
#
class BundleLineItem < LineItem
  belongs_to :product_bundle

  delegate :price, to: :product_bundle

  def name
    base = product_bundle.product.name
    qty = product_bundle.quantity

    "#{base} #{qty}x Bundle"
  end
end

