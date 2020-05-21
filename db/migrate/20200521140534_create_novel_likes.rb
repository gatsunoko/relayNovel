class CreateNovelLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :novel_likes do |t|
      t.integer :user_id
      t.integer :novel_id

      t.timestamps
    end
  end
end
