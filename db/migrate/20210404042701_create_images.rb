class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :image_url
      t.references :product, foreign_key: true
      t.references :driver, foreign_key: true
      t.references :partner, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
