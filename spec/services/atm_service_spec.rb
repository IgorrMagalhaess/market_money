require "rails_helper"

describe AtmService do
  it "get_near_atms", :vcr do
    search = AtmService.new.get_near_atms(37.586297, -79.051824)

    expect(search).to be_a(Hash)
    expect(search[:results]).to be_a(Array)

    atm_data = search[:results].first

    expect(atm_data).to have_key(:dist)
    expect(atm_data[:dist]).to be_a(Integer)

    expect(atm_data).to have_key(:poi)
    expect(atm_data[:poi]).to be_a(Hash)

    expect(atm_data[:poi]).to have_key(:name)
    expect(atm_data[:poi][:name]).to be_a(String)
    
    expect(atm_data).to have_key(:address)
    expect(atm_data[:address]).to be_a(Hash)
    
    expect(atm_data[:address]).to have_key(:freeformAddress)
    expect(atm_data[:address][:freeformAddress]).to be_a(String)


    expect(atm_data).to have_key(:position)
    expect(atm_data[:position]).to be_a(Hash)

    expect(atm_data[:position]).to have_key(:lat)
    expect(atm_data[:position][:lat]).to be_a(Float)
    expect(atm_data[:position][:lon]).to be_a(Float)
    # require 'pry'; binding.pry
  end
end