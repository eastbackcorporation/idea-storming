class CreateCategoryTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :category_types do |t|
      t.string :type_name, null: false
      t.string :name, null: false
      t.integer :disp_order
      t.references :category_type, index: true
    end
  end
end
