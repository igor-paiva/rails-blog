class CommentsController < ApplicationController
  before_action :set_comment, only: %i(update destroy)

  def create
    @comment = Comment.create!(comment_params)

    render :show, status: :created

  rescue ActiveRecord::RecordInvalid
    head :forbidden
  rescue ActiveRecord::ActiveRecordError
    head :unprocessable_entity
  end

  def update
    @comment.update!(comment_params)

    render :show, status: :ok

  rescue ActiveRecord::ActiveRecordError
    head :unprocessable_entity
  end

  def destroy
    @comment.destroy!

    head :ok
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.permit(:content, :post_id)
            .merge(user_id: current_user.id)
    end
end
