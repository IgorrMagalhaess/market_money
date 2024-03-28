class Api::V0::VendorsController < ApplicationController
   def index
      market = Market.find(params[:market_id])
      vendors = market.vendors
      render json: VendorSerializer.new(vendors)
   end

   def show 
      vendor = Vendor.find(params[:id]) 
      render json: VendorSerializer.new(vendor)
   end

   def create
      begin
         vendor = Vendor.create!(vendor_params)
         
         render json: VendorSerializer.new(vendor), status: :created 
      rescue ActiveRecord::RecordInvalid => error
         render json: ErrorSerializer.new(ErrorMessage.new(error.message, 400)).serialize_json, status: 400
      end 
   end

   def update 
      vendor = Vendor.find(params[:id]) 
      vendor.update!(vendor_params)

      render json: VendorSerializer.new(vendor), status: 200
   end

   def destroy 
      vendor = Vendor.find(params[:id]) 
      vendor.destroy
      render json: VendorSerializer.new(vendor), status: 204
   end

   private

   def vendor_params
      params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted )
   end
end