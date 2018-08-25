class PricesController < ApplicationController

  def new
    @price = Price.new
  end
end
