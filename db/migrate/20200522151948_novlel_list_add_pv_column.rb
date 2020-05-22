class NovlelListAddPvColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :novel_lists, :pv_count, :integer
  end
end
