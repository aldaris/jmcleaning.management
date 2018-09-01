class PricesController < ApplicationController

  def index
    prices = Price.all.order(:amount)
    @active_prices = prices.select {|price| price.is_active}
    @inactive_prices = prices.select {|price| !price.is_active}
  end

  def new
    @price = Price.new(is_active: true)
  end

  def create
    @price = Price.new(price_params)

    if @price.valid?
      @price.save
      redirect_to prices_url
    else
      render :new
    end
  end

  private

  def price_params
    params.require(:price).permit(:description, :amount, :is_active)
  end
end
