class CreateThemeWatches < ActiveRecord::Migration[5.2]
  def change
    create_table :theme_watches do |t|
      t.belongs_to :user, null: false
      t.belongs_to :theme, null: false
      t.timestamps
    end
  end
end
