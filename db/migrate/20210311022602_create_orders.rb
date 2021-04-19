class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone_number
      t.string :address
      t.datetime :delivery_time
      t.float :subtotal
      t.float :discount
      t.string :shipping_fee
      t.float :total
      t.integer :status, default: 0
      t.integer :type_checkout
      t.integer :rate_status, default: 0
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: true
      t.references :voucher, foreign_key: true
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
