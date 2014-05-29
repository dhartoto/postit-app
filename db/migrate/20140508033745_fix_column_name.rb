class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :post_categories, :categories_id, :category_id
  end
end
