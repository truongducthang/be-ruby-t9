module Api
  class CategoriesController < ApplicationController
    def retrieve_subcategories
      @subcategories = Category.subcategories.order(id: :asc).limit(8)
      render json: @subcategories, status: :ok
    rescue StandardError
      render json: { error: "Internal Server Error" }, status: :internal_server_error
    end
  end
end
