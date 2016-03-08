require "rails_helper"

RSpec.describe Api::V1::ItemsController do
  describe "GET #index" do
    let (:json_response) { JSON.parse(response.body, symbolize_names: true) }

    it "responds with HTTP 200 success status code" do
      get :index, format: :json

      expect(response.status).to eq(200)
      expect(response).to be_successful
    end

    it "responds with a list of items with name, description, and image_url" do
      item1, item2 = create_list(:item, 2)

      get :index, format: :json

      expect(json_response.first[:name]).to eq(item1.name)
      expect(json_response.last[:name]).to eq(item2.name)
      expect(json_response.first[:description]).to eq(item1.description)
      expect(json_response.last[:description]).to eq(item2.description)
      expect(json_response.first[:image_url]).to eq(item1.image_url)
      expect(json_response.last[:image_url]).to eq(item2.image_url)
      expect(json_response.first[:created_at]).to be_nil
      expect(json_response.last[:created_at]).to be_nil
      expect(json_response.first[:updated_at]).to be_nil
      expect(json_response.last[:updated_at]).to be_nil
    end
  end

  describe "GET #show" do
    let (:json_response) { JSON.parse(response.body, symbolize_names: true) }

    it "responds with HTTP 200 success status code" do
      get :show, id: 1, format: :json

      expect(response.status).to eq(200)
      expect(response).to be_successful
    end

    it "responds with the item's name, description, and image_url" do
      item = create(:item)

      get :show, id: 1, format: :json

      expect(json_response[:name]).to eq(item.name)
      expect(json_response[:description]).to eq(item.description)
      expect(json_response[:image_url]).to eq(item.image_url)
      expect(json_response[:created_at]).to be_nil
      expect(json_response[:updated_at]).to be_nil
    end
  end
end
