class CreateNovels < ActiveRecord::Migration[6.0]
  def change
    create_table :novels do |t|
      t.string :text
      t.integer :user_id
      t.integer :novel_list_id
      t.boolean :selected, null: false, default: false
      t.integer :number

      t.timestamps
    end
  end
end
