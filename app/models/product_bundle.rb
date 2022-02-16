# == Schema Information
#
# Table name: product_bundles
#
#  id         :bigint           not null, primary key
#  price      :decimal(8, 2)    not null
#  quantity   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_product_bundles_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class ProductBundle < ApplicationRecord
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
