class PostsController < ApplicationController
  before_action :set_post, except: %i(create followers_posts)

  def show; end

  def followers_posts
    @posts = Post.user_followers_posts(current_user.id)
  end

  def create
    @post = Post.create!(post_params)

    render :show, status: :created

  rescue ActiveRecord::ActiveRecordError
    head :unprocessable_entity
  end

  def update
    @post.update!(post_params)

    render :show, status: :ok

  rescue ActiveRecord::ActiveRecordError
    head :unprocessable_entity
  end

  def destroy
    @post.destroy!

    head :ok
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.permit(:title, :content)
            .merge(user_id: current_user.id)
    end
end
