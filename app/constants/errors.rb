module Errors
  COMMON = {
    INTERNAL_SERVER_ERROR: "Internal Server Error",
    UNAUTHORIZED: "Unauthorized"
  }.freeze
  AUTH = {
    LOGIN_FAILED: "Authentication failed",
    MISSING_CREDENTIALS: "Email or password is blank",
    ACCOUNT_NOT_APPROVED: "Account is not approved"
  }.freeze
end
