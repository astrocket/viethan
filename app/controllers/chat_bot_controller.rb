require "facebook/messenger"

class ChatBotController < ApplicationController
  include Facebook::Messenger

  def index
    redirect_to root_path if current_user.bot_subscription
  end

  def tell
    Bot.deliver({
                    recipient: {
                        id: current_user.mid
                    },
                    message: {
                        text: "What's up"
                    }
                }, access_token: ENV['ACCESS_TOKEN'])

    redirect_to request.referer || root_url
  end

end
