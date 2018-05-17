
class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:followed_id, :follower_id], unique: true
    #一番最後のは、followedとfollowerの組み合わせがユニーク。二回以上フォローさせることを防ぐ
    #foreign key = add_index

  end
end
