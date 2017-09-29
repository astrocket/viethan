class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.belongs_to :chat, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
