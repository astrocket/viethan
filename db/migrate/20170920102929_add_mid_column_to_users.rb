class AddMidColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :mid, :string
  end
end
