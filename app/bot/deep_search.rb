class DeepSearch < Thredded::ApplicationController

  attr_accessor :current_user

  # override devise current_user to enable pundit policies

  def initialize(user)
    @current_user = user || User.find_by_mid('1270455756391778')
  end

  def deep_search(query)
    topics = exclude_topics(query)
    list = build_template(query, topics)
    return list
  end

  private

  def exclude_topics(query)
    query = query.to_s
    topics = policy_scope(Thredded::Topic.where(messageboard_id: policy_scope(Thredded::Messageboard.all).pluck(:id)))
        .search_query(query)
    return topics.to_a # Thredded::TopicsPageView's instance method
  end

  def build_template(query , topics)
    domain = ENV["VIET_SITE_DOMAIN"] || 'localhost:3000'
    list = "'#{query}' 에 대한 검색 결과는 다음과 같습니다."
    if topics.count == 0
      list << "\n\n관련된 자료를 찾을 수 없습니다.\nhttps://#{domain}/forum 에 들어가서 직접 질문을 올려보세요 !"
    end
    topics.each_with_index do |topic, i|
      list << "\n\n#{i+1}. #{topic.title}\nhttps://#{domain}/#{find_topic_path(topic)}/#{topic.slug}"
    end
    return list
  end

  def current_page
    1.to_i
  end

  def find_topic_path(topic)
    Thredded::UrlsHelper.messageboard_topics_path(topic.messageboard)
  end

end
