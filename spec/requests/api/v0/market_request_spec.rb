require "rails_helper"

describe "Markets API" do
   it 'sends a list of Markets' do
      create_list(:market, 5)

      get "/api/v0/markets"

      expect(response).to be_successful
      
      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data].count).to eq(5)

      markets[:data].each do |market|
         expect(market).to have_key(:id)
         expect(market[:id]).to be_an(String)

         expect(market).to have_key(:type)
         expect(market[:type]).to be_a(String)

         expect(market).to have_key(:attributes)

         expect(market[:attributes]).to have_key(:street)
         expect(market[:attributes][:street]).to be_a(String)

         expect(market[:attributes]).to have_key(:city)
         expect(market[:attributes][:city]).to be_a(String)

         expect(market[:attributes]).to have_key(:county)
         expect(market[:attributes][:county]).to be_a(String)

         expect(market[:attributes]).to have_key(:state)
         expect(market[:attributes][:state]).to be_an(String)

         expect(market[:attributes]).to have_key(:zip)
         expect(market[:attributes][:zip]).to be_an(String)

         expect(market[:attributes]).to have_key(:lat)
         expect(market[:attributes][:lat]).to be_an(String)

         expect(market[:attributes]).to have_key(:lon)
         expect(market[:attributes][:lon]).to be_an(String)

         expect(market[:attributes]).to have_key(:vendor_count)
         expect(market[:attributes][:vendor_count]).to be_an(Integer)
      end
   end

   it 'sends a single market by its id' do 
      id = create(:market).id

      get "/api/v0/markets/#{id}"

      market_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      market = market_response[:data]

      expect(market).to have_key(:id)
      expect(market[:id]).to be_a(String)

      expect(market).to have_key(:type)
      expect(market[:type]).to be_a(String)

      expect(market).to have_key(:attributes)
      expect(market[:attributes]).to be_a(Hash)

      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to be_a(String)

      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to be_a(String)

      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to be_a(String)

      expect(market[:attributes]).to have_key(:county)
      expect(market[:attributes][:county]).to be_a(String)

      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to be_a(String)

      expect(market[:attributes]).to have_key(:zip)
      expect(market[:attributes][:zip]).to be_a(String)

      expect(market[:attributes]).to have_key(:lat)
      expect(market[:attributes][:lat]).to be_a(String)

      expect(market[:attributes]).to have_key(:lon)
      expect(market[:attributes][:lon]).to be_a(String)

      expect(market[:attributes]).to have_key(:vendor_count)
      expect(market[:attributes][:vendor_count]).to be_a(Integer)
   end

   it 'will gracefully handle if invalid id is provided' do
      get "/api/v0/markets/123123123123"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=123123123123")
   end
end