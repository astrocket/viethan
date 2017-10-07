class AddNewsColumnsToThreddedTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :thredded_topics, :news, :boolean, default: false
    add_attachment :thredded_topics, :cover_image
  end
end
