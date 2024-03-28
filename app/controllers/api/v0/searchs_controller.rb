class Api::V0::SearchsController < ApplicationController
   def index
      if params[:state] && params[:name] && params[:city]
         markets = Market.find_by_state_name_and_city(params[:state], params[:city], params[:name])
         render_valid_response(markets)
      elsif params[:state] && params[:city]
         markets = Market.find_by_state_and_city(params[:state], params[:city])
         render_valid_response(markets)
      elsif params[:state] && params[:name]
         markets = Market.find_by_state_and_name(params[:state], params[:name])
         render_valid_response(markets)
      elsif params[:city] && params[:name]
         render_invalid_parameters_response
      elsif params[:name]
         markets = Market.find_by_name(params[:name])
         render_valid_response(markets)
      elsif params[:state] 
         markets = Market.find_by_state(params[:state])
         render_valid_response(markets)
      elsif params[:city]
         render_invalid_parameters_response
      end
   end

   private
   def render_invalid_parameters_response
      message = "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint"
      render json: ErrorSerializer.new(ErrorMessage.new(message, 422)).serialize_json, status: :unprocessable_entity
   end

   def render_valid_response(markets)
      render json: MarketSerializer.new(markets)
   end
end