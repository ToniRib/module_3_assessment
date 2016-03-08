require "rails_helper"

RSpec.describe SearchController, type: :controller do
  describe "GET #index" do
    it "returns a successful HTTP 200 status code" do
      VCR.use_cassette("search_sennheiser") do
        get :index, search: "sennheiser"
      end

      expect(response.status).to eq(200)
      expect(response).to be_successful
    end
  end
end
