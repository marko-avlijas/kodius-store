class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.references :product, null: true, foreign_key: true
      t.references :product_bundle, null: true, foreign_key: true
      t.references :basket, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1
      t.string :type

      t.timestamps
    end
  end
end
