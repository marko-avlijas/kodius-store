class CreatePromotionCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :promotion_codes do |t|
      t.string :code, null: false
      t.decimal :amount, null: false, precision: 8, scale: 2, null: false
      t.string :type, null: false
      t.boolean :can_combine, null: false, default: false

      t.timestamps
    end
  end
end
