class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :country, null: false
      t.string :city, null: false
      t.string :line1, null: false
      t.string :line2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
