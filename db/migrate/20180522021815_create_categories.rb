# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string  :name, null: false
      t.text    :description
      t.integer :disp_order
      t.string  :ancestry
      t.references  :category_type, null: false
      t.timestamps
    end

    add_index :categories, :ancestry
    add_index :categories, :disp_order
  end
end
