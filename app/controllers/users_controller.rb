class UsersController < ApplicationController
  before_action :set_user, except: %i(create)
  before_action :set_follower_relation, only: %i(unfollow)
  skip_before_action :authenticate_user, only: %i(create)

  def show; end

  def create
    @user = User.create!(user_params)

    @token = Knock::AuthToken.new(payload: { sub: @user.id }).token

    render :token, status: :created

  rescue ActiveRecord::ActiveRecordError
    head :unprocessable_entity
  end

  def update
    @user.update!(user_params)

    render :show, status: :ok

  rescue ActiveRecord::ActiveRecordError
    head :unprocessable_entity
  end

  def destroy
    @user.destroy!

    head :ok
  end

  def followers
    @followers = @user.followers
  end

  def followeds
    @followeds = @user.followeds
  end

  def follow
    Follower.create!(follower_id: @user.id, followed_id: params[:user_id])
    
    head :ok

  rescue
    head :unprocessable_entity
  end

  def unfollow
    head :not_found unless @follower_relation

    @follower_relation.destroy!

    head :ok
  end

  private

    def set_follower_relation
      @follower_relation = Follower.find_by(
        follower_id: @user.id,
        followed_id: params[:user_id]
      )
    end

    def set_user
      @user = current_user
    end

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end
