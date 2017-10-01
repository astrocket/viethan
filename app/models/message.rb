class Message < ApplicationRecord
  belongs_to :chat, touch: true
  belongs_to :user
end
