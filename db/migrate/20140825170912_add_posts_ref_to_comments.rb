class AddPostsRefToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :post, index: true
  end
end
