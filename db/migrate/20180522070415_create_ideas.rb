class CreateIdeas < ActiveRecord::Migration[5.2]
  def change
    create_table :ideas do |t|
      t.references :theme, index: true
      t.text :ancestry
      t.bigint :creator_id, null: false
      t.string :title, null: false
      t.text :description
      t.boolean :is_display, default: true, null: false

      t.timestamps
    end

    add_index :ideas, 'ancestry(256)'
  end
end
