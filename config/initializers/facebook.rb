require "facebook/messenger"
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

unless Rails.env.production?
  bot_files = Dir[Rails.root.join('app', 'bot', '**', '*.rb')]
  bot_reloader = ActiveSupport::FileUpdateChecker.new(bot_files) do
    bot_files.each { |file| require_dependency file }
  end

  ActiveSupport::Reloader.to_prepare do
    bot_reloader.execute_if_updated
  end

  bot_files.each { |file| require_dependency file }
end

Facebook::Messenger::Profile.set(
    {
        get_started: {
            payload: 'GET_STARTED_PAYLOAD'
        }
    }, access_token: ENV['ACCESS_TOKEN'])

Facebook::Messenger::Profile.set(
    {
        persistent_menu: [
            {
                locale: 'default',
                composer_input_disabled: false,
                call_to_actions: [
                    {
                        title: 'My Account',
                        type: 'nested',
                        call_to_actions: [
                            {
                                title: "What's a chatbot?",
                                type: 'postback',
                                payload: 'EXTERMINATE'
                            },
                            {
                                title: 'History',
                                type: 'postback',
                                payload: 'HISTORY_PAYLOAD'
                            },
                            {
                                title: 'Contact Info',
                                type: 'postback',
                                payload: 'CONTACT_INFO_PAYLOAD'
                            }
                        ]
                    },
                    {
                        type: 'web_url',
                        title: 'Get some help',
                        url: 'https://github.com/hyperoslo/facebook-messenger',
                        webview_height_ratio: 'full'
                    }
                ]
            },
            {
                locale: 'zh_CN',
                composer_input_disabled: false
            }
        ]
    }, access_token: ENV['ACCESS_TOKEN'])