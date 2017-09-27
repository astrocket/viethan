require "facebook/messenger"
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

if Rails.env.production?

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
                          title: 'Đăng ký',
                          type: 'nested',
                          call_to_actions: [
                              {
                                  title: "Đăng ký tôi",
                                  type: 'postback',
                                  payload: 'START_SUBSCRIPTION'
                              },
                              {
                                  title: 'Dừng đăng ký',
                                  type: 'postback',
                                  payload: 'STOP_SUBSCRIPTION'
                              }
                          ]
                      },
                      {
                          type: 'web_url',
                          title: 'Go to site',
                          url: "https://#{ENV["VIET_SITE_DOMAIN"] || 'localhost:3000'}",
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
else
  bot_files = Dir[Rails.root.join('app', 'bot', '**', '*.rb')]
  bot_reloader = ActiveSupport::FileUpdateChecker.new(bot_files) do
    bot_files.each { |file| require_dependency file }
  end

  ActiveSupport::Reloader.to_prepare do
    bot_reloader.execute_if_updated
  end

  bot_files.each { |file| require_dependency file }
end
