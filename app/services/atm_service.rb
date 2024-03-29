class AtmService 
  def conn 
    conn = Faraday.new("https://api.tomtom.com/search/2") do |faraday|
      faraday.headers['Accept'] = 'application/json'
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_near_atms(lat, lon)
    get_url("https://api.tomtom.com/search/2/categorySearch/cash%20dispenser.json?lat=#{lat}&lon=#{lon}&radius=1000&relatedPois=off&key=#{Rails.application.credentials.tomtom[:key]}") 
  end
end