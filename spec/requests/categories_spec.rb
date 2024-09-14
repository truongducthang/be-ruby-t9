require "rails_helper"

RSpec.describe "Api::Home", type: :request do
  let!(:category) { create(:category, parent_id: nil) }

  describe "GET /api/sub_categories" do
    let!(:user) { create(:user, email: "test@example.com", password: "password") }
    let(:auth_headers) { { "Authorization" => "Bearer #{JwtService.encode(user_id: user.id)}" } }
    let!(:sub_categories) { create_list(:category, 8, image_url: "http://example.com", parent_id: category.id) }
    let!(:new_sub_categories) { create(:category, image_url: "http://example.com", parent_id: category.id) }
    context "when there are products available" do
      before do
        get api_sub_categories_path, headers: auth_headers
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the correct number of products" do
        expect(json_response.size).to eq(8)
        expect(json_response.map { |sc| sc["name"] }).to include(sub_categories.first.name)
        expect(json_response.map { |sc| sc["name"] }).to include(sub_categories.last.name)
      end

      it "not include other sub categories" do
        expect(json_response.map { |sc| sc["name"] }).to_not include(new_sub_categories.name)
      end

      it "returns products with the correct attributes" do
        json_response.each do |product|
          expect(product).to have_key("id")
          expect(product).to have_key("name")
          expect(product).to have_key("image_url")
          expect(product).to have_key("parent_id")
          expect(product).to have_key("created_at")
          expect(product).to have_key("updated_at")
        end
      end
    end

    context "when an internal server error occurs" do
      before do
        allow(Category).to receive(:subcategories).and_raise(StandardError.new("Some error"))
        get api_sub_categories_path, headers: auth_headers
      end

      it "returns an internal server error response" do
        expect(response).to have_http_status(:internal_server_error)
      end

      it "returns an internal server error message" do
        expect(response.body).to include("Internal Server Error")
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
