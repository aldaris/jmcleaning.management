# frozen_string_literal: true

# The backend implementation for the /invoices REST resource.
class InvoicesController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @invoices = pagy(Invoice.all.select(:id, :client_id, :total, :is_invoice_paid)
                                .includes(:client)
                                .order(id: :desc))
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
        send_data @invoice.pdf, filename: "#{@invoice.invoice_id}.pdf", type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def mark_as_paid
    @invoice = Invoice.find(params[:id])
    set_flash_message(@invoice.mark_as_paid)
    page = params[:page].to_i
    redirect_to invoices_path(page: page != 0 ? page : 1)
  end

  private

  def set_flash_message(status)
    if status
      flash[:success] = t('invoices.index.mark_as_paid.success', id: @invoice.invoice_id)
    else
      flash[:failed] = t('invoices.index.mark_as_paid.failed', message: @invoice.errors.full_messages.first)
    end
  end

  def invoice_params
    params
      .require(:invoice)
      .permit(:id, :client_id, :issue_date, :due_date, :pdf, invoice_items_attributes: [:service_id, :quantity])
  end
end
