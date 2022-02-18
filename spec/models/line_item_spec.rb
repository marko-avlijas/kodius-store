# == Schema Information
#
# Table name: line_items
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(1), not null
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
require 'rails_helper'

RSpec.describe LineItem, type: :model do
  fixtures :products, :quantity_discounts

  describe "#total_price" do
    subject { described_class.new(product_id: product.id) }

    context "given product with no quantity discounts" do
      # Price: 49.99
      let(:product) { products(:smart_hub) }

      it "calculates correctly" do
        subject.quantity = 2
        expect(subject.total_price).to eq(99.98)
      end
    end

    context "given product with with 1 quantity discount" do
      # Price: 24.99
      # Discount: 3x for 65.00
      let(:product) { products(:motion_sensor) }
      let(:full_price) { BigDecimal("24.99") }
      let(:discount_price) { BigDecimal("65.00") }

      it "calculates correctly given quantity == discount.quantity - 1" do
        subject.quantity = 2
        expect(subject.total_price).to eq(2 * full_price)
      end

      it "calculates correctly given quantity == discount.quantity" do
        subject.quantity = 3
        expect(subject.total_price).to eq(discount_price)
      end

      it "calculates correctly given quantity == discount.quantity + 1" do
        subject.quantity = 4
        expect(subject.total_price).to eq(discount_price + full_price)
      end

      it "calculates correctly given quantity == 2xdiscount.quantity - 1" do
        subject.quantity = 5
        expect(subject.total_price).to eq(discount_price + full_price * 2)
      end

      it "calculates correctly given quantity == 2xdiscount.quantity" do
        subject.quantity = 6
        expect(subject.total_price).to eq(discount_price * 2)
      end

      it "calculates correctly given quantity == 2xdiscount.quantity + 1" do
        subject.quantity = 7
        expect(subject.total_price).to eq(discount_price * 2 + full_price) 
      end

      it "calculates correctly given quantity == 3xdiscount.quantity - 1" do
        subject.quantity = 8
        expect(subject.total_price).to eq(discount_price * 2 + full_price * 2)
      end

      it "calculates correctly given quantity == 3xdiscount.quantity" do
        subject.quantity = 9
        expect(subject.total_price).to eq(discount_price * 3)
      end

      it "calculates correctly given quantity == 3xdiscount.quantity + 1" do
        subject.quantity = 10 
        expect(subject.total_price).to eq(discount_price * 3 + full_price)
      end
    end
  end
end
