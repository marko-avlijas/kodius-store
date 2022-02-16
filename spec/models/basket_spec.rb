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
        expect(line_item).to have_attributes(product_id: product.id, basket_id: subject.id, quantity: 1, type: "ProductLineItem")
      end
    end

    context "when line item with such product does exist" do
      it "increments quantity by 1" do
        subject.line_items.create(product_id: product.id, quantity: 1, type: "ProductLineItem")

        expect { subject.add_product(product) }.not_to change { LineItem.count }
        
        line_item = LineItem.last
        expect(line_item).to have_attributes(product_id: product.id, basket_id: subject.id, quantity: 2, type: "ProductLineItem")
      end
    end
  end

  describe "#add_product_bundle" do
    let(:bundle) { product_bundles(:motion_sensor_bundle) }

    context "when line item with such product bundle does not exist" do
      it "creates new line item" do
        expect { subject.add_product_bundle(bundle) }.to change { LineItem.count }.by(1)
        
        line_item = LineItem.last
        expect(line_item).to have_attributes(product_bundle_id: bundle.id, basket_id: subject.id, quantity: 1, type: "BundleLineItem")
      end
    end

    context "when line item with such product bundle does exist" do
      it "increments quantity by 1" do
        subject.line_items.create(product_bundle_id: bundle.id, quantity: 1, type: "BundleLineItem")

        expect { subject.add_product_bundle(bundle) }.not_to change { LineItem.count }
        
        line_item = LineItem.last
        expect(line_item).to have_attributes(product_bundle_id: bundle.id, basket_id: subject.id, quantity: 2, type: "BundleLineItem")
      end
    end
  end
end
