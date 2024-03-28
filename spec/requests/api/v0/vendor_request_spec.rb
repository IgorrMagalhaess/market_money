require "rails_helper"

describe 'Vendor API' do
  it 'sends a single vendor by its id #EP4' do
    id = create(:vendor).id

    get "/api/v0/vendors/#{id}"

    vendor_response = JSON.parse(response.body, symbolize_names: true)
    
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

    expect(no_id_vendor[:errors]).to be_a(Array)
    expect(no_id_vendor[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=34567")
  end
end

describe 'Creates a vendor #EP5' do
  it 'creates a vendor #EP5' do
    vendor_params = ({
      name: 'Murder on the Orient Express',
      description: 'Agatha Christie',
      contact_name: 'mystery',
      contact_phone: 'Filled with suspense.',
      credit_accepted: false
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)

    created_vendor = Vendor.last

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(created_vendor.name).to eq(vendor_params[:name])
    expect(created_vendor.description).to eq(vendor_params[:description])
    expect(created_vendor.contact_name).to eq(vendor_params[:contact_name])
    expect(created_vendor.contact_phone).to eq(vendor_params[:contact_phone])
    expect(created_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
  end

  it "does not create a vendor #EP5 " do 
    vendor_params = ({
      name: 'Murder on the Orient Express',
      description: 'Agatha Christie',
      contact_name: 'mystery'
      # contact_phone: 'Filled with suspense.'
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)
    
    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: Contact phone can't be blank, Credit accepted is not included in the list")
  end
end

describe "updates a vendor" do 
  it "can update an existing book" do
    id = create(:vendor).id
    previous_name = Vendor.last.name
    vendor_params = { name: "NAME1" }
    headers = {"CONTENT_TYPE" => "application/json"}
  
    patch "/api/v0/vendors/#{id}", headers: headers, params:  JSON.generate({vendor: vendor_params})

    vendor = Vendor.find_by(id: id)
    
    expect(response).to be_successful
    expect(vendor.name).to_not eq(previous_name)
    expect(vendor.name).to eq("NAME1")
  end

  it "Update vendor #EP6 SAD PATH" do 
    id = create(:vendor).id
    previous_name = Vendor.last.name
    vendor_params = { name: "NAME1" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v0/vendors/12323232", headers: headers, params:  JSON.generate({vendor: vendor_params})
    data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(404)
    expect(response).to_not be_successful
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=12323232")
  end

  it 'SAD PATH EP#6' do
    id = create(:vendor).id
    previous_name = Vendor.last.name
    vendor_params = { contact_name: "" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v0/vendors/#{id}", headers: headers, params:  JSON.generate({vendor: vendor_params})
    
    data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(response).to_not be_successful
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: Contact name can't be blank")
  end
end

describe 'Vendor delete' do
  it 'delete vendor ' do
    vendor = create(:vendor)

    expect(Vendor.count).to eq(1)

    delete "/api/v0/vendors/#{vendor.id}"

    expect(response.status).to eq(204)
    expect(response).to be_successful
    expect(Vendor.count).to eq(0)
  end

  it 'Vendor delete EP#6' do
    delete "/api/v0/vendors/123123123123"

    expect(response.status).to eq(404)
    expect(response).to_not be_successful

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=123123123123")
  end
end