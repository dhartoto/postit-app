class FixFolumnName < ActiveRecord::Migration
  def change
    rename_column :posts, :userid, :user_id
  end
end
