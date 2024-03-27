class Api::V0::MarketVendorsController < ApplicationController
   rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

   def create
      market = Market.find(params[:market_id])
      vendor = Vendor.find(params[:vendor_id])
      market_vendor = MarketVendor.new(market_id: market.id, vendor_id: vendor.id)

      if market_vendor.save
         render json: { message: "Successfully added vendor to market" }, status: :created
      else ActiveModel::Errors => error
         render_error_aldeady_exists_response(market_vendor.errors)
      end
   end

   private
   
   def not_found_response(exception)
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
            .serialize_json_market_vendor, status: :not_found
   end

   def render_error_aldeady_exists_response(exception)
      message = exception.full_messages
      render json: ErrorSerializer.new(ErrorMessage.new(message, 422))
            .serialize_json_already_exits, status: :unprocessable_entity
   end
end