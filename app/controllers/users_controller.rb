class UsersController < ApplicationController
  before_action :set_user, except: %i(create)
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

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end
