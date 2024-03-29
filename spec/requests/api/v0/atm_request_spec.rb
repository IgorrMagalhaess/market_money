require "rails_helper"

describe 'ATM near market' do
  it 'Get Cash Dispensers Near a Market', :vcr do
    market = create(:market, 
      name: "2nd Street Farmers' Market",
      street: "194 second street",
      city: "Amherst",
      county: "Amherst",
      state: "Virginia",
      zip: "24521",
      lat: "37.583311",
      lon: "-79.048573")


    get "/api/v0/markets/#{market.id}/nearest_atms"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    market_atms= JSON.parse(response.body, symbolize_names: true)
    # require 'pry'; binding.pry
    expect(market_atms[:data]).to be_a(Array)
    expect(market_atms[:data].first).to be_a(Hash)

    atm_attributes = market_atms[:data].first[:attributes]

    expect(atm_attributes).to have_key(:name)
    expect(atm_attributes[:name]).to be_a(String)

    expect(atm_attributes).to have_key(:address)
    expect(atm_attributes[:address]).to be_a(String)

    expect(atm_attributes).to have_key(:lat)
    expect(atm_attributes[:lat]).to be_a(Float)

    expect(atm_attributes).to have_key(:lon)
    expect(atm_attributes[:lon]).to be_a(Float)

    expect(atm_attributes).to have_key(:distance)
    expect(atm_attributes[:distance]).to be_a(Float)
  end

  it 'Returns a 404 status and descriptive error message', :vcr do
    invalid_market_id = 99999  

    get "/api/v0/markets/#{invalid_market_id}/nearest_atms"

    
    expect(response.status).to eq(404)
    
    # Parse response body as JSON
    error_response = JSON.parse(response.body, symbolize_names: true)
    # require 'pry'; binding.pry
    # Expectations for error message
    expect(error_response).to have_key(:errors)
    expect(error_response[:errors]).to be_a(Array)
    expect(error_response[:errors].first).to be_a(Hash)
    expect(error_response[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=99999")
  end
end