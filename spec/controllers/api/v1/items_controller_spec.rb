require "rails_helper"

RSpec.describe Api::V1::ItemsController do
  describe "GET #index" do
    it "responds with HTTP 200 success status code" do
      get :index, format: :json

      expect(response.status).to eq(200)
      expect(response).to be_successful
    end
  end
end
