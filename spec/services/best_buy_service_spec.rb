require "rails_helper"

RSpec.describe BestBuyService, type: :model do
  describe "#initialize" do
    it "can be initialized with a one word search term" do
      service = BestBuyService.new("sennheiser")

      expect(service.search_term).to eq("sennheiser")
      expect(service.connection.class).to eq(Faraday::Connection)
      expect(service.response).to be_nil
    end

    it "can be initialized with a multi-word search term" do
      service = BestBuyService.new("sennheiser headphones white")

      expect(service.search_term).to eq("sennheiser%20headphones%20white")
      expect(service.connection.class).to eq(Faraday::Connection)
      expect(service.response).to be_nil
    end
  end

  describe "#find_products" do
    it "returns an array of the first 15 matching products" do
      service = BestBuyService.new("sennheiser")

      products = VCR.use_cassette("search_sennheiser") do
        service.find_products
      end

      first_product = products.first

      expect(products.count).to eq(15)

      expect(first_product.class).to eq(Product)
      expect(first_product.respond_to?(:name)).to be true
      expect(first_product.respond_to?(:short_description)).to be true
      expect(first_product.respond_to?(:sale_price)).to be true
      expect(first_product.respond_to?(:sku)).to be true
      expect(first_product.respond_to?(:image)).to be true
      expect(first_product.respond_to?(:customer_review_average)).to be true
    end

    it "returns an empty array if the search found no products" do
      service = BestBuyService.new("toni rib")

      products = VCR.use_cassette("search_toni_rib") do
        service.find_products
      end

      expect(products.count).to eq(0)
      expect(products).to eq(Array.new)
    end
  end
end
