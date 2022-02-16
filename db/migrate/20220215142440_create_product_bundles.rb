class CreateProductBundles < ActiveRecord::Migration[7.0]
  def change
    create_table :product_bundles do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :price, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
