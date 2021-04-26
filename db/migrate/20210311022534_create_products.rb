class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :quantity_sold, default: 0
      t.float :price
      t.text :description
      t.string :image
      t.integer :status, default: 0
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
