require 'rails_helper'

RSpec.describe Basket, type: :model do
  fixtures :products

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
        subject.line_items.create(product: product, quantity: 1)

        expect { subject.add_product(product) }.not_to change { LineItem.count }
        
        line_item = LineItem.last
        expect(line_item).to have_attributes(product_id: product.id, basket_id: subject.id, quantity: 2)
      end
    end
  end
end
