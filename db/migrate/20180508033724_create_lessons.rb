class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.integer :result

      t.timestamps
    end
    add_index :lessons, [:user_id, :category_id], unique: true

  end
end
