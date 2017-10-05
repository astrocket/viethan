class AddSelfJoiningColumnToThreddedPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :thredded_posts, :parent_post, index: true, required: false
  end
end
