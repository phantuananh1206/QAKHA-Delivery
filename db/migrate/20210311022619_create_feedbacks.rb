class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.text :context
      t.float :point
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: true
      t.integer :parent_id

      t.timestamps
    end
  end
end
