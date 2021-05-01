class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.text :content
      t.string :image
      t.integer :point
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.references :driver, foreign_key: true
      t.references :partner, foreign_key: true

      t.timestamps
    end
  end
end
