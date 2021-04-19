class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :id_card
      t.string :phone_number
      t.string :password
      t.string :license_plate
      t.string :image
      t.integer :status, default: 0
      t.float :coins, default: 0
      t.float :latitude
      t.float :longitude


      t.timestamps
    end
  end
end
