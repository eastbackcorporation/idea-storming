class AddColumnColorToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :color, :string, default: '#d3d3d3'
  end
end
