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

  def create
    @client = Client.new(client_params)

    if @client.valid?
      @client.save
      redirect_to clients_path
    else
      render :new
    end
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

  def remove
    Client.where(id: params[:ids]).destroy_all
    redirect_to clients_path
  end

  private

  def client_params
    params.require(:client).permit(:name, :nick_name, :email_address, :phone_number,
        address_attributes: [:first_line, :second_line, :third_line, :town, :post_code])
  end
end
