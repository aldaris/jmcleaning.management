class ClientsController < ApplicationController

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
    @client.billing_address = Address.new
  end

  def create
    @billing_address = Address.new(address_params)
    @billing_address.save
    @client = Client.new(client_params)
    @client.billing_address_id = @billing_address.id
    @client.save
    redirect_to @client
  end

  private
    def client_params
      params.require(:client).permit(:name, :nick_name, :email_address, :phone_number, :billing_address_attributes)
    end

  def address_params
    params.require(:billing_address).permit(:first_line, :second_line, :third_line, :town, :post_code)
  end
end
