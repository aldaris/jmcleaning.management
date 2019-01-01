class InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all.select(:id, :client_id, :due_date).includes(:client).order(id: :desc).limit(10)
  end

  def new
    @invoice = Invoice.new
    @invoice.issue_date = Date.today
    @invoice.due_date = Date.today + 3.days
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.valid?
      @invoice.save
      pdf = InvoicePdf.new(@invoice)
      @invoice.update_attribute(:pdf, pdf.render)
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

  private

  def invoice_params
    params.require(:invoice).permit(:client_id, :issue_date, :due_date,
        invoice_items_attributes: [:service_id, :quantity])
  end
end
