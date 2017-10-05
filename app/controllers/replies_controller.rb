class RepliesController < ApplicationController
  before_action :set_parent_post

  def new
    @reply = @parent_post.child_posts.new
  end

  def create
    @post_form = Thredded::PostForm.new(
        user: current_user, topic: @parent_post.postable, post_params: {content: params[:reply][:content]}
    )
    @post_form.post.parent_post = @parent_post
    @post_form.save

    redirect_to request.referrer
  end

  private

  def set_parent_post
    @parent_post = Thredded::Post.find(params[:parent_post_id])
  end

end
