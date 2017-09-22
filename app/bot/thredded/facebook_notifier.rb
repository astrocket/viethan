# frozen_string_literal: true

module Thredded
  require "facebook/messenger"
  class FacebookNotifier
    include Facebook::Messenger

    def human_name
      I18n.t('settings.notifier.facebook_messenger')
    end

    def key
      'facebook_messenger'
    end

    def new_post(post, users)
      post_bot_notification(post.id, users.map(&:mid)).deliver_now
    end

    def new_private_post(post, users)
      message_bot_notification(post.id, users.map(&:mid)).deliver_now
    end

    def find_record(klass, id_or_record)
      # Check by name because in development the Class might have been reloaded after id was initialized
      id_or_record.class.name == klass.name ? id_or_record : klass.find(id_or_record)
    end

    def post_bot_notification(post_id, mids)
      @post = find_record Thredded::Post, post_id
      domain = ENV["VIET_SITE_DOMAIN"] || 'localhost:3000'
      url = "http://#{domain}/forum/#{@post.messageboard.slug}/#{@post.postable.slug}"

      mids.each do |mid|
        unless mid.nil?
          Bot.deliver(
              {
                  recipient: { 'id' => mid },
                  message: {
                      text: "#{@post.postable.title}(#{url})"
                  }
              }, access_token: ENV["ACCESS_TOKEN"])
        end
      end

    end

    def message_bot_notification(post_id, emails)
      @post = find_record Thredded::PrivatePost, post_id
      domain = ENV["VIET_SITE_DOMAIN"] || 'localhost:3000'
      url = "http://#{domain}/forum/#{@post.messageboard.slug}/#{@post.postable.slug}"

      mids.each do |mid|
        unless mid.nil?
          Bot.deliver(
              {
                  recipient: { 'id' => mid },
                  message: {
                      text: "#{@post.postable.title}(#{url})"
                  }
              }, access_token: ENV["ACCESS_TOKEN"])
        end
      end
    end
  end
end
