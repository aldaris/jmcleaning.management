class InvoicesController < ApplicationController

  def index
    @draft_invoices = Invoice.where(is_draft: true)
  end

  def new
    @invoice = Invoice.new
    @invoice.issue_date = Date.today
    @invoice.due_date = Date.today + 7.days
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.valid?
      @invoice.save
      redirect_to invoices_path
    else
      render :new
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:client_id, :issue_date, :due_date,
        invoice_items_attributes: [:service_id, :quantity])
  end
end
