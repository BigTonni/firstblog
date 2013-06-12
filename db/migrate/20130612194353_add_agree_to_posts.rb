class AddAgreeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :agree, :integer, :null => false, :default => 0
  end
end
