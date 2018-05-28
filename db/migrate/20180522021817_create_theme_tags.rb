class CreateThemeTags < ActiveRecord::Migration[5.2]
  def change
    create_table :theme_tags do |t|
      t.references :tag, index: true
      t.references :theme, index: true
      t.timestamps
    end
  end
end
