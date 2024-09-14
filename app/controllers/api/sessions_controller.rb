module Api
  class SessionsController < ApplicationController
    def create
      if params[:email].blank? || params[:password].blank?
        render json: { code: 400, message: Errors::AUTH[:MISSING_CREDENTIALS] }, status: :bad_request
        return
      end

      user = User.find_by(email: params[:email])

      if user&.authenticate(params[:password])
        if user.approved?
          token = JwtService.encode(user_id: user.id)
          render json: {
            token:,
            user: serialize_resource(user, serializer: UserSerializer, auth_info: true)
          }, status: :ok
        else
          render json: { code: 403, message: Errors::AUTH[:ACCOUNT_NOT_APPROVED] }, status: :forbidden
        end
      else
        render json: { code: 401, message: Errors::AUTH[:LOGIN_FAILED] }, status: :unauthorized
      end
    end
  end
end
