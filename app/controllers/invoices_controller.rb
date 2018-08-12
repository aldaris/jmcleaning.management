class InvoicesController < ApplicationController
  def index
    @draft_invoices = Invoice.where(is_draft: true)
  end

  def new
    @invoice = Invoice.new
  end
end
