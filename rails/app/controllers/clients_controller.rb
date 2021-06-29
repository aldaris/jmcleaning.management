# frozen_string_literal: true

# The backend implementation for the /clients REST resource.
class ClientsController < ApplicationController
  def index
    @clients = Client.all.select(:id, :name).order(:name)
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
    @client.address = Address.new
  end

  def edit
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(create_client_params)

    if @client.valid?
      @client.save
      redirect_to clients_path
    else
      render :new
    end
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      redirect_to client_path(params[:id])
    else
      render :edit
    end
  end

  def search
    if params.key?(:name)
      @clients = Client
                 .select(:id, :name)
                 .where('lower(name) LIKE ?', "%#{params.require(:name).downcase}%")
                 .order('name ASC')
                 .limit(10)
    else
      @clients = Client.all.order('name ASC').limit(10)
    end

    render layout: nil
  end

  def card
    client = Client.find(params[:id])
    render layout: nil, partial: 'card', locals: { client: client }
  end

  private

  def client_params
    params
      .require(:client)
      .permit(:name, :nick_name, :email_address, :extra_line, :phone_number,
              address_attributes: [:id, :first_line, :second_line, :third_line, :town, :post_code])
  end

  def create_client_params
    client_params.tap do |params|
      params.require(:address_attributes)
    end
  end
end
