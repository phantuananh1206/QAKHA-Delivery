class CreateCoins < ActiveRecord::Migration[6.0]
  def change
    create_table :coins do |t|
      t.float :coins_loaded
      t.string :loading_form
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
