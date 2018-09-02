class ServicesController < ApplicationController

  def index
    services = Service.all.order(:price)
    @active_services = services.select {|price| price.is_active}
    @inactive_services = services.reject {|price| price.is_active}
  end

  def new
    @service = Service.new(is_active: true)
  end

  def create
    @service = Service.new(price_params)

    if @service.valid?
      @service.save
      redirect_to services_path
    else
      render :new
    end
  end

  private

  def price_params
    params.require(:service).permit(:description, :price, :is_active)
  end
end
