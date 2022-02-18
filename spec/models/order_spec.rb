# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  fixtures :all

  describe "#transfer_line_items_and_promotions_from_basket" do
    let(:basket) { Basket.create! }
    let(:user) { User.create!(email: "test@examle.com") }
    subject { Order.create!(user: user) }

    let(:product1) { products(:smart_hub) }
    let(:product2)  { products(:motion_sensor) }

    let(:line_item1) { LineItem.create!(product: product1, quantity: 2, basket: basket) }
    let(:line_item2) { LineItem.create!(product: product2, quantity: 1, basket: basket) }

    let(:promo_code1) { percent_discounts(:discount_5_percent_off) }
    let(:promo_code2) { amount_discounts(:discount_20_euro_off) }

    it "transfers line items correctly" do
      basket.line_items << line_item1
      basket.line_items << line_item2

      expect do
        subject.transfer_line_items_and_promotions_from_basket(basket)
      end.not_to change { LineItem.count }

      line_item1.reload
      expect(line_item1).to have_attributes(basket_id: nil, order_id: subject.id, product_id: product1.id, quantity: 2)
      line_item2.reload
      expect(line_item2).to have_attributes(basket_id: nil, order_id: subject.id, product_id: product2.id, quantity: 1)
    end

    it "transfers promotion codes correctly" do
      basket.promotion_codes << promo_code1
      basket.promotion_codes << promo_code2

      subject.transfer_line_items_and_promotions_from_basket(basket)
      expect(subject.promotion_codes.count).to eq(2)
      expect(subject.promotion_code_ids).to match_array([promo_code1.id, promo_code2.id])
    end
  end
end
