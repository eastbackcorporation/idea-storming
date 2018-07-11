class AddColumnColorToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar_color, :integer, default: 0
  end
end
