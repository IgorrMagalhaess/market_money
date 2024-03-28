require "rails_helper"

describe "Search Endpoint" do
   it 'can get all markets by state' do
      markets_ma = create_list(:market, 5, state: 'Georgia')
      markets_ga = create_list(:market, 5, state: 'Massachusetts')
      market = create(:market, state: 'Colorado')


      get "/api/v0/markets/search?state=ssachu", 
            headers: { 'Content-Type' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data].length).to eq(5)
      expect(markets[:data].first[:attributes][:state]).to eq("Massachusetts")
      expect(markets[:data].last[:attributes][:state]).to eq("Massachusetts")
      expect(markets[:data].last[:attributes][:state]).to_not eq("Colorado")
   end

   it 'can get all markets by state and city' do
      markets = create_list(:market, 5, state: 'Georgia', city: 'Atlanta')
      market = create(:market, state: 'Georgia', city: 'Augusta')

      get "/api/v0/markets/search?state=Georgia&city=Atlanta", 
            headers: { 'Content-Type' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data].length).to eq(5)
      expect(markets[:data].first[:attributes][:state]).to eq("Georgia")
      expect(markets[:data].first[:attributes][:city]).to eq("Atlanta")
      expect(markets[:data].last[:attributes][:state]).to eq("Georgia")
      expect(markets[:data].last[:attributes][:city]).to eq("Atlanta")
      expect(markets[:data].last[:attributes][:city]).to_not eq("Augusta")
   end

   it 'can get a market by city, state, and name' do
      markets = create_list(:market, 5, state: 'Georgia', city: 'Atlanta')
      market_1 = create(:market, name: "Flea Market", state: 'Georgia', city: 'Atlanta')

      get "/api/v0/markets/search?state=Georgia&city=Atlanta&name=Flea Market", 
            headers: { 'Content-Type' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      market_response = JSON.parse(response.body, symbolize_names: true)
      market = market_response[:data].first

      expect(market).to have_key(:id)
      expect(market[:id]).to eq(market_1.id.to_s)

      expect(market).to have_key(:type)
      expect(market[:type]).to eq("market")

      expect(market).to have_key(:attributes)
      expect(market[:attributes]).to be_a(Hash)

      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to eq(market_1.name)

      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to eq(market_1.street)

      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to eq(market_1.city)

      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to eq(market_1.state)
   end

   it 'can get a market by state and name' do
      markets = create_list(:market, 5, state: 'Georgia')
      market_1 = create(:market, name: "Flea Market", state: 'Georgia')

      get "/api/v0/markets/search?state=Georgia&name=Flea Market", 
            headers: { 'Content-Type' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      market_response = JSON.parse(response.body, symbolize_names: true)
      market = market_response[:data].first

      expect(market).to have_key(:id)
      expect(market[:id]).to eq(market_1.id.to_s)

      expect(market).to have_key(:type)
      expect(market[:type]).to eq("market")

      expect(market).to have_key(:attributes)
      expect(market[:attributes]).to be_a(Hash)

      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to eq(market_1.name)

      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to eq(market_1.street)

      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to eq(market_1.city)

      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to eq(market_1.state)
   end

   it 'can get a market by name' do
      markets = create_list(:market, 5)
      market_1 = create(:market, name: "Flea Market")

      get "/api/v0/markets/search?name=Flea Market", 
            headers: { 'Content-Type' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      market_response = JSON.parse(response.body, symbolize_names: true)
      market = market_response[:data].first

      expect(market).to have_key(:id)
      expect(market[:id]).to eq(market_1.id.to_s)

      expect(market).to have_key(:type)
      expect(market[:type]).to eq("market")

      expect(market).to have_key(:attributes)
      expect(market[:attributes]).to be_a(Hash)

      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to eq(market_1.name)

      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to eq(market_1.street)

      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to eq(market_1.city)

      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to eq(market_1.state)
   end

   describe "errors" do
      it 'can not get market just by city' do
         markets = create_list(:market, 5, city: 'Atlanta')
      market_1 = create(:market, name: "Flea Market", city: 'Atlanta')

      get "/api/v0/markets/search?city=Atlanta", 
            headers: { 'Content-Type' => 'application/json' }

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response[:errors].first).to have_key(:detail)
      expect(error_response[:errors].first[:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint")
      end

      it 'can not get market just by city and name' do
         markets = create_list(:market, 5, city: 'Atlanta')
         market_1 = create(:market, name: "Flea Market", city: 'Atlanta')

         get "/api/v0/markets/search?city=Atlanta&name=Flea Market", 
               headers: { 'Content-Type' => 'application/json' }

         expect(response).to_not be_successful
         expect(response.status).to eq(422)

         error_response = JSON.parse(response.body, symbolize_names: true)

         expect(error_response[:errors].first).to have_key(:detail)
         expect(error_response[:errors].first[:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint")
      end
   end
end