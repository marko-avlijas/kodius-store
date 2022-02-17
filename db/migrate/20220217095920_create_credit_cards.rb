class CreateCreditCards < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_cards do |t|
      t.string :number, null: false
      t.date :expiry_date, null: false
      t.integer :cvv2, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
