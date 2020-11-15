class ApplicationController < ActionController::API
  include Knock::Authenticable

  before_action :authenticate_user

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

    def not_found
      head :not_found
    end
end
