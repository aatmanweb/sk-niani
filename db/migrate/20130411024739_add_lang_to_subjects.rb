class AddLangToSubjects < ActiveRecord::Migration
  def change
 add_column :subjects, :lang, :text
  end
end
