require 'rails_helper'

describe "Item API" do
  it "get all" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
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

  it "get one by id" do
    items = create_list(:item, 3)

    get "/api/v1/items/#{items.last.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to be_a(Hash)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it "create an item" do
    merchant = create(:merchant)
    params = { name: "Catalytic Converter", description: "Who cares where it comes from platinum is platinum", unit_price: 1000, merchant_id: merchant.id}
    headers = { "Content-Type" => "application/json" }

    item_count = Item.all.length

    post "/api/v1/items", headers: headers, params: JSON.generate(params)

    expect(response).to be_successful
    expect(Item.all.length).to eq(item_count + 1)

    created = JSON.parse(response.body, symbolize_names: true)

    item = created[:data]

    expect(item).to be_a(Hash)
    expect(item[:attributes][:name]).to eq("Catalytic Converter")
    expect(item[:attributes][:description]).to eq("Who cares where it comes from platinum is platinum")
    expect(item[:attributes][:unit_price]).to eq(1000)
    expect(item[:attributes][:merchant_id]).to eq(merchant.id)
  end

  it "delete an item" do
    item = create(:item)
    item.save
    item_count = Item.all.length

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.all.length).to eq(item_count - 1)
  end

  it "update an item" do
    item = create(:item)
    item.save
    params = { name: "Catalytic Converter", description: "Who cares where it comes from platinum is platinum", unit_price: 1000}
    headers = { "Content-Type" => "application/json" }

    put "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(params)

    updated_item = Item.find(item.id)

    expect(response).to be_successful
    expect(updated_item.name).to eq("Catalytic Converter")
    expect(updated_item.description).to eq("Who cares where it comes from platinum is platinum")
    expect(updated_item.unit_price).to eq(1000.0)
  end

  it "get an items merchant" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data]).to be_a(Hash)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it "finds one item by name fragment" do
   item1 = create(:item, name:"Spoon")
   item2 = create(:item, name:"Spork")
   item3 = create(:item)
   item4 = create(:item)
   item5 = create(:item)
   item6 = create(:item)
   item7 = create(:item)

   get "/api/v1/items/find?name=Spo"

   item = JSON.parse(response.body, symbolize_names: true)
   
   expect(item[:data]).to be_a(Hash)

   expect(item[:data][:attributes]).to have_key(:name)
   expect(item[:data][:attributes][:name]).to be_a(String)

   expect(item[:data][:attributes]).to have_key(:description)
   expect(item[:data][:attributes][:description]).to be_a(String)

   expect(item[:data][:attributes]).to have_key(:unit_price)
   expect(item[:data][:attributes][:unit_price]).to be_a(Float)

   expect(item[:data][:attributes]).to have_key(:merchant_id)
   expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end
end
