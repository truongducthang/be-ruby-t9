module Api
  class ProductsController < ApplicationController
    def retrieve_newest_products
      @products = Product.order(updated_at: :desc).limit(4)
      render json: @products, status: :ok
    end

    def retrieve_recommended_products
      @products = Product.order(recommendation_score: :desc).limit(20)
      render json: @products, status: :ok
    end

    end
  end
end
