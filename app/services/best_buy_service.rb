class BestBuyService
  attr_reader :connection, :response, :search_term

  def initialize(search_term)
    @search_term = search_term

    set_up_connection
  end

  def find_products
    get_api_response

    build_products
  end

  private

  def best_buy_url
    "https://api.bestbuy.com/v1/products(longDescription=#{search_term}*)"
  end

  def set_up_connection
    @connection = Faraday.new(url: best_buy_url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_api_response
    response = connection.get do |conn|
      conn.params["apiKey"] = ENV['BEST_BUY_KEY']
      conn.params["show"] = response_options
      conn.params["pageSize"] = "15"
      conn.params["format"] = "json"
    end

    @response = JSON.parse(response.body, symbolize_names: true)
  end

  def response_options
    "sku,name,salePrice,customerReviewAverage,shortDescription,image"
  end

  def build_products
    response[:products].map do |product|
      Product.new(name: product[:name],
                  sku: product[:sku],
                  image: product[:image],
                  short_description: product[:shortDescription],
                  sale_price: product[:salePrice],
                  customer_review_average: product[:customerReviewAverage])
    end
  end
end
