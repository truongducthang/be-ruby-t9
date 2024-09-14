# app/services/jwt_service.rb
class JwtService
  JWT_SECRET_KEY = Rails.application.credentials.jwt_secret_key

  def self.encode(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, JWT_SECRET_KEY)
  end

  def self.decode(token)
    raise JWT::DecodeError, "Token is blacklisted" if BlacklistToken.exists?(token:)

    decoded_token = JWT.decode(token, JWT_SECRET_KEY).first
    HashWithIndifferentAccess.new(decoded_token)
  rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
    raise ExceptionHandler::InvalidToken
  end
end
