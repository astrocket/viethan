class AddBotSubscriptionColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bot_subscription, :boolean, default: false
    add_column :users, :key, :string
  end
end
