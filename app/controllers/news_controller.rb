class NewsController < ApplicationController
  def index
    @news = Thredded::Topic.where(news: true)
  end
end
