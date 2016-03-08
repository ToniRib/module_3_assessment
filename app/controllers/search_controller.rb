class SearchController < ApplicationController
  def index
    @results = BestBuyService.new(params[:search]).find_products
  end
end
