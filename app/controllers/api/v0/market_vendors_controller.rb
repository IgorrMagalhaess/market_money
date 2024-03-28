class Api::V0::MarketVendorsController < ApplicationController
   rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
   before_action :find_market_and_vendor, only: [:create, :destroy]
   before_action :find_market_vendor, only: [:destroy]

   def create
      market_vendor = MarketVendor.new(market_id: @market.id, vendor_id: @vendor.id)

      if market_vendor.save
         render json: { message: "Successfully added vendor to market" }, status: :created
      else
         render_error_already_exists_response(market_vendor.errors)
      end
   end

   def destroy
      @market_vendor.destroy
      head :no_content
   end

   private

   def find_market_and_vendor
      @market = Market.find(params[:market_id])
      @vendor = Vendor.find(params[:vendor_id])
   end
   
   def not_found_response(exception)
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
            .serialize_json_market_vendor, status: :not_found
   end

   def render_error_already_exists_response(exception)
      message = exception.full_messages
      render json: ErrorSerializer.new(ErrorMessage.new(message, 422))
            .serialize_json_already_exits, status: :unprocessable_entity
   end

   def find_market_vendor
      @market_vendor = MarketVendor.find_by(market_id: params[:market_id], vendor_id: params[:vendor_id])
   end
end