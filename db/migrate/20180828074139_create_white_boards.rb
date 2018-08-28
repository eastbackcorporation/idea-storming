class CreateWhiteBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :white_boards do |t|
      t.belongs_to :theme, null: false
      t.json :content
      t.timestamps
    end
  end
end
