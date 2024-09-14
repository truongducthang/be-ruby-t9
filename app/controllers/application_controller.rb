class ApplicationController < ActionController::Base
  include SerializationHelper
  include Authenticable
  include ExceptionHandler

  protect_from_forgery with: :null_session
end
