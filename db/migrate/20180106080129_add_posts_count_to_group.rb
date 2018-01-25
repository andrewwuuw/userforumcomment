class AddPostsCountToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :posts_count, :integer
  end
end
