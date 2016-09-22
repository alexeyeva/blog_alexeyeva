class AddDefaultValuesToPostInfo < ActiveRecord::Migration[5.0]
  def change
    change_column :post_infos, :views, :integer, default: 0
    change_column :post_infos, :likes, :integer, default: 0
    change_column :post_infos, :rating, :integer, default: 0
  end
end
