require "rails_helper"

RSpec.describe "Api::Sessions", type: :request do
  describe "POST /sessions" do
    let!(:user) { create(:user, email: "test@example.com", password: "password") }
    context "with valid credentials" do
      it "returns a token and status 200" do
        post "/api/sessions", params: { email: "test@example.com", password: "password" }
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("token")
        expect(json_response).to have_key("user")
        expect(json_response["user"]["email"]).to eq("test@example.com")
      end
    end

    context "with invalid credentials" do
      it "returns error message and status 401 with wrong email" do
        post "/api/sessions", params: { email: "test1@example.com", password: "password" }

        expect(response).to have_http_status(:unauthorized)

        json_response = JSON.parse(response.body)
        expect(json_response["code"]).to eq(401)
        expect(json_response["message"]).to eq(Errors::AUTH[:LOGIN_FAILED])
      end

      it "returns error message and status 401 with wrong password" do
        post "/api/sessions", params: { email: "test@example.com", password: "wrongpassword" }

        expect(response).to have_http_status(:unauthorized)

        json_response = JSON.parse(response.body)
        expect(json_response["code"]).to eq(401)
        expect(json_response["message"]).to eq(Errors::AUTH[:LOGIN_FAILED])
      end
    end

    context "when missing email or password" do
      it "returns 400 Bad Request when email is missing" do
        post "/api/sessions", params: { password: "password" }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["code"]).to eq(400)
        expect(JSON.parse(response.body)["message"]).to eq(Errors::AUTH[:MISSING_CREDENTIALS])
      end

      it "returns 400 Bad Request when password is missing" do
        post "/api/sessions", params: { email: "user@example.com" }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["code"]).to eq(400)
        expect(JSON.parse(response.body)["message"]).to eq(Errors::AUTH[:MISSING_CREDENTIALS])
      end
    end

    context "when an internal server error occurs" do
      before do
        allow(User).to receive(:find_by).and_raise(StandardError.new("Something went wrong"))
      end
      it "returns 500 Internal Server Error" do
        post "/api/sessions", params: { email: "test@example.com", password: "password" }

        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)["code"]).to eq(500)
        expect(JSON.parse(response.body)["message"]).to eq(Errors::COMMON[:INTERNAL_SERVER_ERROR])
      end
    end

    context "when user account is not approved" do
      let(:unapproved_user) { create(:user, approved: false, password: "password") }
      it "returns 403 Forbidden" do
        post "/api/sessions", params: { email: unapproved_user.email, password: "password" }

        expect(response).to have_http_status(:forbidden)
        expect(JSON.parse(response.body)["code"]).to eq(403)
        expect(JSON.parse(response.body)["message"]).to eq(Errors::AUTH[:ACCOUNT_NOT_APPROVED])
      end
    end
  end
end
