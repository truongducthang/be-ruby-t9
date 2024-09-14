module ExceptionHandler
  extend ActiveSupport::Concern

  class InvalidToken < StandardError; end

  # Handle internal server_error with all api
  included do
    rescue_from StandardError, with: :handle_internal_server_error
  end

  private

  def handle_internal_server_error(error)
    Rails.logger.error("Internal Server Error: #{error.message}")
    Rails.logger.error(error.backtrace.join("\n")) if Rails.env.development?

    render json: { code: 500, message: Errors::COMMON[:INTERNAL_SERVER_ERROR] }, status: :internal_server_error
  end
end
