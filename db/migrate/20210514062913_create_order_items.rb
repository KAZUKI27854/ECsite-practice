class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :item_id
      t.integer :order_id
      t.integer :quantity
      t.integer :market_price
      t.integer :product_status, default: 0
      t.timestamps
    end
  end
end
