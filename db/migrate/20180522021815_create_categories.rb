# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string  :title, null: false
      t.text    :description
      t.integer :disp_order
      t.timestamps
    end

    add_index :categories, :disp_order
  end
end
