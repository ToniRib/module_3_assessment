class SearchController < ApplicationController
  def index
    @products = BestBuyService.new(params[:search]).find_products
  end
end
