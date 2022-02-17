class AddOrdersIdToLineItems < ActiveRecord::Migration[7.0]
  def change
    remove_reference :line_items, :basket, foreign_key: true
    add_reference :line_items, :basket, null: true, foreign_key: true
    add_reference :line_items, :order, null: true, foreign_key: true
  end
end
