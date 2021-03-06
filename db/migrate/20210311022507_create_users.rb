class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :password
      t.string :image
      t.float :coins, default: 0
      t.integer :role, null: false, default: 1

      t.timestamps
    end
  end
end
