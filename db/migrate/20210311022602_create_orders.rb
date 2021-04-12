class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone_number
      t.string :address
      t.datetime :delivery_time
      t.float :total_price_products
      t.float :discount
      t.float :total_price
      t.string :shipping_fee
      t.string :float
      t.integer :status
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: true
      t.references :voucher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
