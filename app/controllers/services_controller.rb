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

  def inactivate
    service = Service.inactivate(params[:id])
    if service.save
      flash[:success] = t 'services.index.inactivate.success'
    else
      flash[:failed] = t 'services.index.inactivate.failed'
    end
    redirect_to services_path
  end

  def duplicate
    @service = Service.find(params[:id]).dup
    render :new
  end

  private

  def price_params
    params.require(:service).permit(:description, :price, :is_active)
  end
end
