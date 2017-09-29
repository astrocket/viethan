json.extract! chat, :id, :user_id, :room_title, :category, :banned, :created_at, :updated_at
json.url chat_url(chat, format: :json)
