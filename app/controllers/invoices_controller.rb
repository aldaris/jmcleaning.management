class InvoicesController < ApplicationController
  def index
    @draft_invoices = Invoice.where(is_draft: true)
  end

  def new
    @invoice = Invoice.new
    @invoice.issue_date = Date.today
  end
end
