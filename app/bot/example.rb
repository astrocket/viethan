# app/bot/example.rb
require 'facebook/messenger'
include Facebook::Messenger

Bot.on :message do |message|
  message.reply(text: 'Hello, human!')
end


#You can reply to messages sent by the human:
Bot.on :message do |message|
  message.id # => 'mid.1457764197618:41d102a3e1ae206a38'
  message.sender # => { 'id' => '1008372609250235' }
  message.seq # => 73
  message.sent_at # => 2016-04-22 21:30:36 +0200
  message.text # => 'Hello, bot!'
  message.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]

  message.reply(text: 'Hello, human!')
end

# send the human messages out of the blue:

Bot.deliver(
    {
        recipient: {
            id: '45123'
        },
        message: {
            text: 'Human?'
        }
    }, access_token: ENV['ACCESS_TOKEN'])

# The human may require visual aid to understand:

message.reply(
    attachment: {
        type: 'image',
        payload: {
            url: 'http://sky.net/visual-aids-for-stupid-organisms/pig.jpg'
        }
    }
)

#  The human may appreciate hints:

message.reply(
    text: 'Human, who is your favorite bot?',
    quick_replies: [
        {
            content_type: 'text',
            title: 'You are!',
            payload: 'HARMLESS'
        }
    ]
)

# The human may require simple options to communicate:

message.reply(
    attachment: {
        type: 'template',
        payload: {
            template_type: 'button',
            text: 'Human, do you like me?',
            buttons: [
                {type: 'postback', title: 'Yes', payload: 'HARMLESS'},
                {type: 'postback', title: 'No', payload: 'EXTERMINATE'}
            ]
        }
    }
)
# When the human has selected an option, you can act on it:
Bot.on :postback do |postback|
  postback.sender # => { 'id' => '1008372609250235' }
  postback.recipient # => { 'id' => '2015573629214912' }
  postback.sent_at # => 2016-04-22 21:30:36 +0200
  postback.payload # => 'EXTERMINATE'

  if postback.payload == 'EXTERMINATE'
    puts "Human #{postback.recipient} marked for extermination"
  end
end

# Typing indicator : Show the human you are preparing a message for them:

Bot.on :message do |message|
  message.typing_on

  # Do something expensive

  message.reply(text: 'Hello, human!')
end

# Or that you changed your mind:

Bot.on :message do |message|
  message.typing_on

  if # something
  message.reply(text: 'Hello, human!')
  else
    message.typing_off
  end
end

# You can mark messages as seen to keep the human on their toes:

Bot.on :message do |message|
  message.mark_seen
end

# You can keep track of messages sent to the human:

Bot.on :message_echo do |message_echo|
  message_echo.id # => 'mid.1457764197618:41d102a3e1ae206a38'
  message_echo.sender # => { 'id' => '1008372609250235' }
  message_echo.seq # => 73
  message_echo.sent_at # => 2016-04-22 21:30:36 +0200
  message_echo.text # => 'Hello, bot!'
  message_echo.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]

# Log or store in your storage method of choice (skynet, obviously)
end

# You can keep track of message requests accepted by the human:

Bot.on :message_request do |message_request|
  message_request.accept? # => true

# Log or store in your storage method of choice (skynet, obviously)
end

# When the human clicks the Send to Messenger button embedded on a website, you will receive an optin event.

Bot.on :optin do |optin|
  optin.sender # => { 'id' => '1008372609250235' }
  optin.recipient # => { 'id' => '2015573629214912' }
  optin.sent_at # => 2016-04-22 21:30:36 +0200
  optin.ref # => 'CONTACT_SKYNET'

  optin.reply(text: 'Ah, human!')
end

# You can stalk the human:

Bot.on :delivery do |delivery|
  delivery.ids # => 'mid.1457764197618:41d102a3e1ae206a38'
  delivery.sender # => { 'id' => '1008372609250235' }
  delivery.recipient # => { 'id' => '2015573629214912' }
  delivery.at # => 2016-04-22 21:30:36 +0200
  delivery.seq # => 37

  puts "Human was online at #{delivery.at}"
end

# When the human follows a m.me link with a ref parameter like http://m.me/mybot?ref=myparam, you will receive a referral event.

Bot.on :referral do |referral|
  referral.sender # => { 'id' => '1008372609250235' }
  referral.recipient # => { 'id' => '2015573629214912' }
  referral.sent_at # => 2016-04-22 21:30:36 +0200
  referral.ref # => 'MYPARAM'
end

# You can greet new humans to entice them into talking to you, in different locales:

Facebook::Messenger::Profile.set(
    {
        greeting: [
            {
                locale: 'default',
                text: 'Welcome to your new bot overlord!'
            },
            {
                locale: 'fr_FR',
                text: 'Bienvenue dans le bot du Wagon !'
            }
        ]
    }, access_token: ENV['ACCESS_TOKEN'])

# You can define the action to trigger when new humans click on the Get Started button. Before doing it you should check to select the messaging_postbacks field when setting up your webhook.

Facebook::Messenger::Profile.set(
    {
        get_started: {
            payload: 'GET_STARTED_PAYLOAD'
        }
    }, access_token: ENV['ACCESS_TOKEN'])

# You can show a persistent menu to humans.

Facebook::Messenger::Profile.set(
    {
        persistent_menu: [
            {
                locale: 'default',
                composer_input_disabled: true,
                call_to_actions: [
                    {
                        title: 'My Account',
                        type: 'nested',
                        call_to_actions: [
                            {
                                title: "What's a chatbot? ",
                                type: ' postback ',
                                payload: ' EXTERMINATE '
                            },
                            {
                                title: ' History ',
                                type: ' postback ',
                                payload: ' HISTORY_PAYLOAD '
                            },
                            {
                                title: ' Contact Info ',
                                type: ' postback ',
                                payload: ' CONTACT_INFO_PAYLOAD '
                            }
                        ]
                    },
                    {
                        type: ' web_url ',
                        title: ' Get some help ',
                        url: ' https : // github.com/hyperoslo/facebook-messenger ',
                        webview_height_ratio: ' full '
                    }
                ]
            },
            {
                locale: ' zh_CN ',
                composer_input_disabled: false
            }
        ]
    }, access_token: ENV[' ACCESS_TOKEN '])