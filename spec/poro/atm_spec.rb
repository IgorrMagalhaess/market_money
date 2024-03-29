
require 'rails_helper'

RSpec.describe Atm do
  it "initializes with attributes" do 
    attributes = {
      poi: {
        name: "Bank Of The James"
      },
      address: {
        freeformAddress: "164 South Main Street, Amherst, VA 24521"
      },
      position: {
        lat: 37.586297,
        lon: -79.051824
      },
      dist: 438.497338
    }

    atm = Atm.new(attributes)

    expect(atm).to be_a Atm
    expect(atm.id).to eq nil
    expect(atm.name).to eq "Bank Of The James"
    expect(atm.address).to eq "164 South Main Street, Amherst, VA 24521"
    expect(atm.lat).to eq 37.586297
    expect(atm.lon).to eq -79.051824
    expect(atm.distance).to eq 438.497338
  end
end