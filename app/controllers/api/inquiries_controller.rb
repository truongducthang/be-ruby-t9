module Api
  class InquiriesController < ApplicationController
    def by_status
      status_param = params[:status]
      status = Inquiry::STATUS[status_param.to_sym] if Inquiry::STATUS.key?(status_param.to_sym)

      # Nếu không có status hợp lệ, mặc định là PENDING
      status ||= Inquiry::STATUS[:PENDING]

      @inquiries = Inquiry.where(status: status).limit(10)

      render json: @inquiries, each_serializer: InquirySerializer, status: :ok
    end
  end
end
