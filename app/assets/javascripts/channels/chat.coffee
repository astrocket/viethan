render_current_user_message = (data) ->
  unless data.content.blank?
    $('#messages').append "<li>" + data.message_user.email.split('@')[0] + " 내메시지: " + data.content + "</li>"
    $('#message_content').val ""
    $('.message-box').scrollTop($('.message-box')[0].scrollHeight);
  return

render_other_user_message = (data) ->
  unless data.content.blank?
    $('#messages').append "<li>" + data.message_user.email.split('@')[0] + " : " + data.content + "</li>"
    $('#message_content').val ""
    $('.message-box').scrollTop($('.message-box')[0].scrollHeight);
  return

user_id = ->
  $('#chatContainer').data 'current-user-id'

chat_id = ->
  $('#chatContainer').data 'chat-id'

options = { channel: "ChatChannel", chat_id: chat_id() }
App.chat = App.cable.subscriptions.create options,
  connected: ->
# Called when the subscription is ready for use on the server

  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
  # Called when there's incoming data on the websocket for this channel
    if data.message_user.id == user_id()
      render_current_user_message(data)
    else
      render_other_user_message(data)
      update_read_conversations()
