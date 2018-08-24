class CreateMindMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :mind_maps do |t|
      t.belongs_to :theme, null: false
      t.json :content
      t.timestamps
    end
  end
end
