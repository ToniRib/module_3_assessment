require "rails_helper"

RSpec.describe SearchController, type: :controller do
  describe "GET #index" do
    it "returns a successful HTTP 200 status code" do
      get :index

      expect(response.status).to eq(200)
      expect(response).to be_successful
    end
  end
end
