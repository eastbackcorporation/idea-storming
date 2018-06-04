class CreateIdeaLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :idea_likes do |t|
      t.belongs_to :user, null: false
      t.belongs_to :idea, null: false
      t.timestamps
    end
  end
end
