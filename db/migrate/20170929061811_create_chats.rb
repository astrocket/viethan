class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.belongs_to :user, foreign_key: true
      t.string :room_title
      t.string :category
      t.boolean :banned, default: false
      t.boolean :anonymous, default: false

      t.timestamps
    end
  end
end
