class ClientsController < ApplicationController

  def index
    @clients = Client.all.order(:name)
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
    @client.address = Address.new
  end

  def create
    Client.create(client_params)
    redirect_to clients_path
  end

  def search
    if (params.has_key?(:name))
      @clients = Client.select(:id, :name)
                     .where("lower(name) LIKE ?", "%#{params.require(:name).downcase}%")
                     .order("name ASC")
                     .limit(10)
    else
      @clients = Client.all.order("name ASC").limit(10)
    end

    render layout: nil
  end

  def card
    @client = Client.find(params[:id])
    render layout: nil
  end

  private

  def client_params
    params.require(:client).permit(:name, :nick_name, :email_address, :phone_number,
        address_attributes: [:first_line, :second_line, :third_line, :town, :post_code])
  end
end
