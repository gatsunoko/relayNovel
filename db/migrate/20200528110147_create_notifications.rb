class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :post_user_id
      t.integer :novel_list_id
      t.integer :text_pattern
      t.boolean :checked

      t.timestamps
    end
  end
end
