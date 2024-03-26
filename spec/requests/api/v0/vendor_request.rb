require "rails_helper"

describe 'Vendor API' do
  it 'sends a single vendor by its id #EP4' do
    id = create(:vendor).id
    vendor_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    vendor
  end
end