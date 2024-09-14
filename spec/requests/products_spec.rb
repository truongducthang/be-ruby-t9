require "rails_helper"

RSpec.describe "Api::Product", type: :request do
  let!(:products) { create_list(:product, 5) }
  let!(:user) { create(:user, email: "test@example.com", password: "password") }
  let(:auth_headers) { { "Authorization" => "Bearer #{JwtService.encode(user_id: user.id)}" } }
  # let(:user) { create(:user)}

  # before do
  #   sign_in user
  # end

  describe "GET /api/products/newest" do
    context "when there are products available" do
      before do
        get newest_api_products_path, headers: auth_headers
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the correct number of products" do
        expect(json_response.size).to eq(4)
      end

      it "returns products with the correct attributes" do
        json_response.each do |product|
          expect(product).to have_key("id")
          expect(product).to have_key("name")
          expect(product).to have_key("description")
          expect(product).to have_key("price")
          expect(product).to have_key("gender")
          expect(product).to have_key("recommendation_score")
          expect(product).to have_key("image_url")
          expect(product).to have_key("rating")
          expect(product).to have_key("rating_record")
          expect(product).to have_key("product_variants")
          expect(product).to have_key("created_at")
          expect(product).to have_key("updated_at")

          product["product_variants"].each do |variant|
            expect(variant).to have_key("id")
            expect(variant).to have_key("size")
            expect(variant).to have_key("color")
            expect(variant).to have_key("sku")
            expect(variant).to have_key("stock_quantity")
            expect(variant).to have_key("image_url")
            expect(variant).to have_key("is_main_image_product")

            expect(variant["size"]).to have_key("id")
            expect(variant["size"]).to have_key("size")

            expect(variant["color"]).to have_key("id")
            expect(variant["color"]).to have_key("color")
          end
        end
      end
    end

    context "when an internal server error occurs" do
      before do
        allow_any_instance_of(Product).to receive(:rating_info).and_raise(StandardError.new("Some error"))
        get newest_api_products_path, headers: auth_headers
      end

      it "returns an internal server error response" do
        expect(response).to have_http_status(:internal_server_error)
      end

      it "returns an internal server error message" do
        expect(response.body).to include("Internal Server Error")
      end
    end
  end

  describe "GET /api/products/recommended" do
    let!(:recommended_products) { create_list(:product, 20, recommendation_score: 5) }
    let(:low_recommended_product) {  create(:product, recommendation_score: 1) }

    context "when there are products available" do
      before do
        get recommended_api_products_path, headers: auth_headers
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the correct number of products" do
        expect(json_response.size).to eq(20)
        expect(json_response.map { |product| product["name"] }).to include(recommended_products.first.name)
        expect(json_response.map { |product| product["name"] }).to include(recommended_products.last.name)
      end

      it "not include low recommended product" do
        expect(json_response.map { |product| product["name"] }).to_not include(low_recommended_product.name)
      end

      it "returns products with the correct attributes" do
        json_response.each do |product|
          expect(product).to have_key("id")
          expect(product).to have_key("name")
          expect(product).to have_key("description")
          expect(product).to have_key("price")
          expect(product).to have_key("gender")
          expect(product).to have_key("recommendation_score")
          expect(product).to have_key("image_url")
          expect(product).to have_key("rating")
          expect(product).to have_key("rating_record")
          expect(product).to have_key("product_variants")
          expect(product).to have_key("created_at")
          expect(product).to have_key("updated_at")

          product["product_variants"].each do |variant|
            expect(variant).to have_key("id")
            expect(variant).to have_key("size")
            expect(variant).to have_key("color")
            expect(variant).to have_key("sku")
            expect(variant).to have_key("stock_quantity")
            expect(variant).to have_key("image_url")
            expect(variant).to have_key("is_main_image_product")

            expect(variant["size"]).to have_key("id")
            expect(variant["size"]).to have_key("size")

            expect(variant["color"]).to have_key("id")
            expect(variant["color"]).to have_key("color")
          end
        end
      end
    end

    context "when an internal server error occurs" do
      before do
        allow_any_instance_of(Product).to receive(:rating_info).and_raise(StandardError.new("Some error"))
        get newest_api_products_path, headers: auth_headers
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
