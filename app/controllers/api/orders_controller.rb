module Api
    class OrdersController < ApplicationController
        def unshipped
            @orders = Order.unshipped_ordered_by_purchase_date
            render json: @orders, include: :order_items
        end

        def unshipped_products
            @order_items = OrderItem.unshipped_with_details
            render json: @order_items, each_serializer: UnshippedProductSerializer
        end

    end
end
