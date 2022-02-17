class CreateOrdersPromotionsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :orders, :promotion_codes do |t|
      # t.index [:order_id, :promotion_code_id]
      t.index [:promotion_code_id, :order_id], unique: true
    end
  end
end
