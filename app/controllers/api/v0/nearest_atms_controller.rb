class Api::V0::NearestAtmsController < ApplicationController
  def index 
    market = Market.find(params[:market_id])
    facade = AtmFacade.new(market.lat, market.lon )
    atms = facade.near_atms
    render json: AtmSerializer.new(atms)
  end
end
