class NovelChangeTextColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :novels, :text, :text
  end
end
