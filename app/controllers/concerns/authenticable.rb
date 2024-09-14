module Authenticable
  extend ActiveSupport::Concern

  def authenticate_user
    auth_header = request.headers["Authorization"]
    if auth_header.present? && auth_header.start_with?("Bearer ")
      @current_token = auth_header.split.last
      begin
        decoded = JwtService.decode(@current_token)
        @current_user = User.find(decoded[:user_id])
      rescue ActiveRecord::RecordNotFound, ExceptionHandler::InvalidToken
        render json: { code: 401, messaged: Errors::COMMON[:UNAUTHORIZED] }, status: :unauthorized
      end
    else
      render json: { code: 401, messaged: Errors::COMMON[:UNAUTHORIZED] }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  def current_token
    @current_token
  end
end
