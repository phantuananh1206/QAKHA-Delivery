class CreatePartners < ActiveRecord::Migration[6.0]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :password
      t.datetime :time_open
      t.datetime :time_close
      t.integer :status
      t.float :latitude
      t.float :longitude
      t.string :image
      t.references :city, null: false, foreign_key: true
      t.references :type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
