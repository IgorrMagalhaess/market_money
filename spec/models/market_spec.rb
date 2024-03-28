require 'rails_helper'

RSpec.describe Market do
   describe "relationships" do
      it { should have_many(:market_vendors) }
      it { should have_many(:vendors).through(:market_vendors) }
   end

   

   describe "Instance methods" do
      it '#vendor_count' do
         market = create(:market)
         vendors = create_list(:vendor, 5)

         vendors.each do |vendor|
            create(:market_vendor, vendor_id: vendor.id, market_id: market.id)
         end

         expect(market.vendor_count).to eq(5)
      end
   end

   describe "class methods" do
      it ".find_by_state_name_and_city" do
         markets = create_list(:market, 5, state: 'Georgia', city: 'Atlanta')
         market_1 = create(:market, name: "Flea Market", state: 'Georgia', city: 'Atlanta')

         expect(Market.find_by_state_name_and_city("Georgia", "Atlanta", "Flea Market")).to eq([market_1])
      end

      it ".find_by_state_and_city" do
         markets = create_list(:market, 5, state: 'Georgia', city: 'Atlanta')
         market = create(:market, state: 'Georgia', city: 'Augusta')

         expect(Market.find_by_state_and_city("Georgia", "Atlanta").count).to eq(5)
         expect(Market.find_by_state_and_city("Georgia", "Atlanta").first).to eq(markets.first)
      end

      it '.find_by_state_and_name' do
         markets = create_list(:market, 5, state: 'Georgia')
         market_1 = create(:market, name: "Flea Market", state: 'Georgia')

         expect(Market.find_by_state_and_name("Georgia", "Flea Market")).to eq([market_1])
      end

      it '.find_by_name' do
         markets = create_list(:market, 5)
         market_1 = create(:market, name: "Flea Market")

         expect(Market.find_by_name("Flea Market")).to eq([market_1])
      end

      it '.find_by_state' do
         markets_ga = create_list(:market, 5, state: 'Georgia')
         markets_ma = create_list(:market, 5, state: 'Massachusetts')
         market = create(:market, state: 'Colorado')

         expect(Market.find_by_state("Massachusetts").count).to eq(5)
         expect(Market.find_by_state("Massachusetts").first).to eq(markets_ma.first)
      end
   end
end
