class ChangePosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer
    add_column :posts, :comments_counter, :integer
  end
end
