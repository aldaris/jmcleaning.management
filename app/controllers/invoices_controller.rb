# frozen_string_literal: true

# The backend implementation for the /invoices REST resource.
class InvoicesController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @invoices = pagy(Invoice.all.select(:id, :client_id, :total).includes(:client).order(id: :desc))
  end

  def new
    @invoice = Invoice.new
    @invoice.prepare
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save_with_pdf
      redirect_to invoices_path
    else
      render :new
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.pdf do
        @invoice.pdf = InvoicePdf.new(@invoice).render
        @invoice.update_attribute(:pdf, @invoice.pdf)
        send_data @invoice.pdf, filename: "#{@invoice.invoice_id}.pdf", type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  private

  def invoice_params
    params
      .require(:invoice)
      .permit(:id, :client_id, :issue_date, :due_date, :pdf, invoice_items_attributes: [:service_id, :quantity])
  end
end
