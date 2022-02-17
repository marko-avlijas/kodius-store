class CreatePromotionsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :baskets, :promotion_codes do |t|
      # t.index [:basket_id, :promotion_code_id]
      t.index [:promotion_code_id, :basket_id], unique: true,
              name: 'index_baskets_promotion_codes_on_both_keys'
    end
  end
end
