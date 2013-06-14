class AddKeyColumnToPages < ActiveRecord::Migration
  def change
add_column :pages, :sub_subject_id, :integer
add_index(:pages, :sub_subject_id)
  end
end
