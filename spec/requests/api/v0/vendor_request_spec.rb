require "rails_helper"

describe 'Vendor API' do
  it 'sends a single vendor by its id #EP4' do
    id = create(:vendor).id

    get "/api/v0/vendors/#{id}"

    vendor_response = JSON.parse(response.body, symbolize_names: true)
    
    # require 'pry'; binding.pry
    expect(response).to be_successful
    vendor = vendor_response[:data]


    expect(vendor).to have_key(:id)
    expect(vendor[:id]).to be_a(String)

    expect(vendor).to have_key(:type)
    expect(vendor[:type]).to be_a(String)

    expect(vendor).to have_key(:attributes)
    expect(vendor[:attributes]).to be_a(Hash)

    expect(vendor[:attributes]).to have_key(:name)
    expect(vendor[:attributes][:name]).to be_a(String)

    expect(vendor[:attributes]).to have_key(:description)
    expect(vendor[:attributes][:description]).to be_a(String)
    
    expect(vendor[:attributes]).to have_key(:contact_name)
    expect(vendor[:attributes][:contact_name]).to be_a(String)
    
    expect(vendor[:attributes]).to have_key(:contact_phone)
    expect(vendor[:attributes][:contact_phone]).to be_a(String)
    
    expect(vendor[:attributes]).to have_key(:credit_accepted)
    expect(vendor[:attributes][:credit_accepted]).to be_in([true, false])
    
  end

  it "sends a single vendor by its id #EP4 SAD PATH" do 
    get "/api/v0/vendors/34567"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    no_id_vendor = JSON.parse(response.body, symbolize_names: true)
    # require 'pry'; binding.pry

    expect(no_id_vendor[:errors]).to be_a(Array)
    expect(no_id_vendor[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=34567")
  end
end