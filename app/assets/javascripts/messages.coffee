# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
###
$(document).on "turbolinks:load", ->
  if $("#vink_messages").length
    $("#vink_messages").scrollTop $("#vink_messages")[0].scrollHeight
    $('#message_content').on 'keydown', (event) ->
      if event.keyCode is 13 && !event.shiftKey && event.target.value.trim() != ''
        $('input').click()
        event.target.value = ''
        event.preventDefault()###
