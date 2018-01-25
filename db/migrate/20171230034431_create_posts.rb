class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
