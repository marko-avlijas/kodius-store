# == Schema Information
#
# Table name: line_items
#
#  id                :bigint           not null, primary key
#  quantity          :integer          default(1), not null
#  type              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  basket_id         :bigint           not null
#  product_bundle_id :bigint
#  product_id        :bigint
#
# Indexes
#
#  index_line_items_on_basket_id          (basket_id)
#  index_line_items_on_product_bundle_id  (product_bundle_id)
#  index_line_items_on_product_id         (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (basket_id => baskets.id)
#  fk_rails_...  (product_bundle_id => product_bundles.id)
#  fk_rails_...  (product_id => products.id)
#
class ProductLineItem < LineItem
  belongs_to :product

  delegate :name, :price, to: :product
end
