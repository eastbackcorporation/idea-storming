class CreateThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :themes do |t|
      t.string :title, null: false
      t.text :description
      t.bigint :owner_id, null: false
      t.references :category, index: true
      t.timestamps
    end

    add_index :themes, :owner_id
  end
end
