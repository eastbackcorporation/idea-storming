class AddColumnMainImageIdToThemes < ActiveRecord::Migration[5.2]
  def change
    add_column :themes, :main_image_id, :bigint
  end
end
