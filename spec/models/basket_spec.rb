# == Schema Information
#
# Table name: baskets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Basket, type: :model do
  fixtures :all

  subject { Basket.create }

  describe "#add_product" do
    let(:product) { products(:smart_hub) }

    context "when line item with such product does not exist" do
      it "creates new line item" do
        expect { subject.add_product(product) }.to change { LineItem.count }.by(1)
        
        line_item = LineItem.last
        expect(line_item).to have_attributes(product_id: product.id, basket_id: subject.id, quantity: 1)
      end
    end

    context "when line item with such product does exist" do
      it "increments quantity by 1" do
        subject.line_items.create(product_id: product.id, quantity: 1)

        expect { subject.add_product(product) }.not_to change { LineItem.count }
        
        line_item = LineItem.last
        expect(line_item).to have_attributes(product_id: product.id, basket_id: subject.id, quantity: 2)
      end
    end
  end

  describe "#total_before_promotions" do
    let(:product1) { products(:smart_hub) }                   # price: 49.99
    let(:product2) { products(:motion_sensor) }               # price: 24.99
    let(:discount1)  { product_bundles(:motion_sensor_bundle) } # price: 65.00
    let(:bundle2)  { product_bundles(:smoke_sensor_bundle) }  # price: 35.00

    it "returns 0 given no line items" do
      expect(subject.total_before_promotions).to eq(0)
    end

    it "correctly sums 1 product line item with quantity 1" do
      subject.line_items.create(product_id: product1.id, quantity: 1)
      expect(subject.total_before_promotions).to eq(49.99)
    end

    it "correctly sums 1 product line item with quantity 2" do
      subject.line_items.create(product_id: product1.id, quantity: 2)
      expect(subject.total_before_promotions).to eq(99.98)
    end

    it "correctly sums 2 line items" do
      subject.line_items.create(product_id: product1.id, quantity: 2)
      subject.line_items.create(product_id: product2.id, quantity: 1)
      expect(subject.total_before_promotions).to eq(99.98 + 24.99)
    end
  end

  describe "#total" do
    let(:product)  { products(:motion_sensor) } # price: 24.99
    let(:price) { BigDecimal("24.99") }
    before do
      subject.line_items.create(product_id: product.id, quantity: 1)
    end

    it "without promo codes returns total_before_promotions" do
      expect(subject.total_before_promotions).to eq(price)
      expect(subject.total).to eq(price)
    end

    it "correctly applies one promo code" do
      subject.promotion_codes << percent_discounts(:discount_20_percent_off)
      expect(subject.total).to eq((price * 0.8).round(2))
    end

    it "correctly applies multiple promo codes" do
      subject.promotion_codes << percent_discounts(:discount_5_percent_off)
      subject.promotion_codes << amount_discounts(:discount_20_euro_off)
      expect(subject.total).to eq((price - (price * 0.05) - 20).round(2))
    end
  end
end
