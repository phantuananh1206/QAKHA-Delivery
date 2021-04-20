class CreateVouchers < ActiveRecord::Migration[6.0]
  def change
    create_table :vouchers do |t|
      t.string :code
      t.float :discount
      t.float :condition
      t.integer :status, default: 0
      t.datetime :expiry_date
      t.integer :usage_limit
      t.text :description
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
