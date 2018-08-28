class PricesController < ApplicationController

  def index
    prices = Price.all.order(:amount)
    @active_prices = prices.select {|price| price.is_active}
    @inactive_prices = prices.select {|price| !price.is_active}
  end

  def new
    @price = Price.new
  end

  def create
    Price.create(price_params)
    redirect_to prices_url
  end

  private

  def price_params
    params.require(:price).permit(:description, :amount, :is_active)
  end
end
