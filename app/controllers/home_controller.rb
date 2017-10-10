class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @posts_page_view = Thredded::PostsPageView.new(current_user, Thredded::Post.last(15).reverse!)
    @news = Thredded::Topic.where(news: true).order(created_at: :desc)
  end
end
