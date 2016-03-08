class Product
  attr_reader :name, :sku, :image, :short_description,
              :sale_price, :customer_review_average

  def initialize(name:, sku:, image:, short_description:,
                 sale_price:, customer_review_average:)
    @name                    = name
    @sku                     = sku
    @image                   = image
    @short_description       = short_description
    @sale_price              = sale_price
    @customer_review_average = customer_review_average || not_available
  end

  private

  def not_available
    "Not Available"
  end
end
