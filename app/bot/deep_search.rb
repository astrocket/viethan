class DeepSearch < Thredded::ApplicationController

  attr_accessor :current_user

  # override devise current_user to enable pundit policies

  def initialize(user)
    @current_user = user || NullUser.new
  end

  def deep_search(query)
    topics = exclude_topics(query)
    list = build_template(topics)
    return list
  end

  private

  def exclude_topics(query)
    query = query.to_s

    topics = Thredded::TopicsPageView.new(
        @current_user,
        policy_scope(Thredded::Topic.where(messageboard_id: policy_scope(Thredded::Messageboard.all).pluck(:id)))
            .search_query(query)
            .order_recently_posted_first
            .includes(:categories, :last_user, :user)
            .page(current_page)
    )
    return topics.to_a # Thredded::TopicsPageView's instance method
  end

  def build_template(topics)
    domain = ENV["VIET_SITE_DOMAIN"] || 'localhost:3000'
    list = ''
    topics.each do |topic|
      list << "#{topic.title} : https://#{domain}/#{topic.messageboard_path}/#{topic.title} \n"
    end
    return list
  end

  def current_page
    1.to_i
  end

end
