class SearchController < ApplicationController
  def index
    @products = BestBuyService.new(params[:search]).find_products
    @search_term = params[:search]
  end
end
