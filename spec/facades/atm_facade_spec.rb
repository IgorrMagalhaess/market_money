require "rails_helper"

RSpec.describe AtmFacade do
  describe '#initialize' do
    it 'creates an Atm facade object', :vcr do
      facade = AtmFacade.new(1, 2)

      expect(facade).to be_an_instance_of(AtmFacade)
    end
  end

  describe '#near_atms' do
    it 'calls get_near_atms on service and returns an array of Atm objects', :vcr do
      
      facade = AtmFacade.new(37.586297, -79.051824)

      atms = facade.near_atms

      expect(atms).to be_an(Array)
      expect(atms.first).to be_an_instance_of(Atm)
      expect(atms.first.lat).to be_a Float
      expect(atms.first.lon).to be_a Float
      expect(atms.first.name).to be_a String
      expect(atms.first.address).to be_a String
    end
  end 
end