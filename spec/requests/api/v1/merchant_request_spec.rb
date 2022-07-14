require 'rails_helper'

describe "Merchant API" do
  it "get all" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "get one by id" do
    merchants = create_list(:merchant, 3)

    get "/api/v1/merchants/#{merchants.last.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data]).to be_a(Hash)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it "shows all items belonging to a merchant" do
   merchant = create(:merchant)
   item1 = create(:item, merchant_id: merchant.id)
   item2 = create(:item, merchant_id: merchant.id)
   item3 = create(:item, merchant_id: merchant.id)
   item4 = create(:item, merchant_id: merchant.id)

   get "/api/v1/merchants/#{merchant.id}/items"

   json = JSON.parse(response.body, symbolize_names: true)
   items = json[:data]

   expect(response).to be_successful
   expect(items.count).to eq 4

   items.each do |item|
     expect(item).to have_key(:id)
     expect(item[:id]).to be_a String

     expect(item).to have_key(:type)
     expect(item[:type]).to be_a String
     expect(item[:type]).to eq("item")

     expect(item).to have_key(:attributes)

     expect(item[:attributes]).to have_key(:name)
     expect(item[:attributes][:name]).to be_a String

     expect(item[:attributes]).to have_key(:description)
     expect(item[:attributes][:description]).to be_a String

     expect(item[:attributes]).to have_key(:unit_price)
     expect(item[:attributes][:unit_price]).to be_a Float

     expect(item[:attributes]).to have_key(:merchant_id)
     expect(item[:attributes][:merchant_id]).to be_a Integer
   end
 end
end
