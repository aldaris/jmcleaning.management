# frozen_string_literal: true

# The backend implementation for the /services REST resource.
class ServicesController < ApplicationController
  def index
    @active_services = Service.where(is_active: true).order(:price)
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
