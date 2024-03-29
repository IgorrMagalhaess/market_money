class AtmFacade
  attr_reader :atms

  def initialize(lat,lon, service = AtmService.new) 
    # require 'pry'; binding.pry
    @lat = lat 
    @lon = lon
    @service = service
    @atms = nil
  end

  def near_atms
    @atms ||= begin 
      atm_json = @service.get_near_atms(@lat, @lon)
      @atms = atm_json[:results].map {|atm_data| Atm.new(atm_data)}
    end
  end
end