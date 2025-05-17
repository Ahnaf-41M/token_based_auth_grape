module Helpers
  module AuthHelpers
    extend Grape::API::Helpers

    def current_user
      return @current_user if @current_user

      token = headers["Authorization"]&.split(" ")&.last
      payload = JsonWebToken.decode(token)
      @current_user = User.find(payload[:user_id]) if payload[:user_id]
    end

    def authenticate_user!
      error!("Unauthorized user!", 401) unless current_user
    end
  end
end
