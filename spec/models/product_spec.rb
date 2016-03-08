RSpec.describe Product, type: :model do
  describe "#initialize" do
    it "can be initialized with valid params" do
      product = Product.new(product_params)

      expect(product.name).to eq("Product")
      expect(product.short_description).to eq("short description")
      expect(product.sku).to eq(849381)
      expect(product.image).to eq("image.png")
      expect(product.sale_price).to eq("543.21")
      expect(product.customer_review_average).to eq("5.0")
    end
  end

  def product_params
    {
      name: "Product",
      short_description: "short description",
      sku: 849381,
      image: "image.png",
      sale_price: "543.21",
      customer_review_average: "5.0"
    }
  end
end
