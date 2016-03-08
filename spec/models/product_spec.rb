RSpec.describe Product, type: :model do
  describe "#initialize" do
    it "can be initialized with valid params" do
      product = Product.new(product_params)

      expect(product.name).to eq("Product")
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
