class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
