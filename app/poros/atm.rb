class Atm 
  attr_reader :name, :address, :lat, :lon, :distance, :id
  def initialize(attributes)
    @id = nil 
    @name = attributes[:poi][:name]
    @address = attributes[:address][:freeformAddress]
    @lat = attributes[:position][:lat]
    @lon = attributes[:position][:lon]
    @distance = attributes[:dist]
  end
end