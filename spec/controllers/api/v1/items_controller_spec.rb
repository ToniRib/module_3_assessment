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
      item = create(:item)

      get :show, id: item.id, format: :json

      expect(response.status).to eq(200)
      expect(response).to be_successful
    end

    it "responds with the item's name, description, and image_url" do
      item = create(:item)

      get :show, id: item.id, format: :json

      expect(json_response[:name]).to eq(item.name)
      expect(json_response[:description]).to eq(item.description)
      expect(json_response[:image_url]).to eq(item.image_url)
      expect(json_response[:created_at]).to be_nil
      expect(json_response[:updated_at]).to be_nil
    end
  end

  describe "DELETE #destroy" do
    let (:json_response) { JSON.parse(response.body, symbolize_names: true) }

    it "responds with HTTP 204 success status code if item is deleted" do
      item = create(:item)

      delete :destroy, id: item.id, format: :json

      expect(Item.count).to eq(0)
      expect(response.status).to eq(204)
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    let (:json_response) { JSON.parse(response.body, symbolize_names: true) }

    it "responds with HTTP 201 success status code if item is created" do
      img = "https://pbs.twimg.com/profile_images" \
            "/619573624903761920/EGZ2I6wG.jpg"

      post :create, format: :json, item: { name:        "Kitten",
                                           description: "Super cute",
                                           image_url:   img }

      expect(response.status).to eq(201)
      expect(response).to be_successful
    end

    it "responds with the name, description, and image_url of the item" do
      img = "https://pbs.twimg.com/profile_images" \
            "/619573624903761920/EGZ2I6wG.jpg"

      post :create, format: :json, item: { name:        "Kitten",
                                           description: "Super cute",
                                           image_url:   img }

      expect(json_response[:name]).to eq("Kitten")
      expect(json_response[:description]).to eq("Super cute")
      expect(json_response[:image_url]).to eq(img)
    end
  end
end
