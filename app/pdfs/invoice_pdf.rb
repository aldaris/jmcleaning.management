# frozen_string_literal: true

# Generates an invoice PDF based on the database representation of an invoice.
class InvoicePdf < Prawn::Document
  def initialize(invoice)
    super()
    render_header(invoice)

    move_cursor_to 500
    font_size 11
    render_invoice_items_table(invoice)
    move_down 40
    font_size 18
    render_payment_advice(invoice)

    render_footer
  end

  private

  def render_header(invoice)
    image asset_path('small-logo.png'), at: [367, 720], width: 120
    move_cursor_to 675
    text 'INVOICE', size: 36
    move_cursor_to 630
    text "#{invoice.client.name}\n#{invoice.client.address.compact_lines.join("\n")}"
    formatted_text_box invoice_details(invoice), at: [370, 630], width: 80, height: 100, size: 10
    text_box owner_details,
             at: [470, 630], width: 70, height: 60, align: :right, size: 10
  end

  def invoice_details(invoice)
    [
      { text: "Invoice Date\n", styles: [:bold] },
      { text: "#{invoice.issue_date.strftime('%d %b %Y')}\n\n" },
      { text: "Invoice Number\n", styles: [:bold] },
      { text: invoice.invoice_id }
    ]
  end

  def owner_details
    "#{Settings.owner.name}\n#{Settings.owner.address.join("\n")}"
  end

  def render_invoice_items_table(invoice)
    size = invoice.invoice_items.size
    table(invoice_items_data(invoice), cell_style: { borders: [], padding: [4, 4, 4, 4] }) do
      columns(0).width = 360
      columns(1..3).style(align: :right, width: 60)
      row(0).style(font_style: :bold, borders: [:bottom])
      rows(1..size).style(borders: [:bottom], border_width: 0.5, border_color: 'cccccc')
      row(size + 1).style(borders: [:top], border_width: 1, border_color: '000000', font_style: :bold, size: 16)
    end
  end

  def render_payment_advice(invoice)
    text "Due Date: #{invoice.due_date.strftime('%d %B %Y')}", style: :bold
    move_down 12
    text 'PAYMENT ADVICE'
    font_size 11
    text bank_details
  end

  def bank_details
    "Electronic Payments: #{Settings.owner.bank.company}, Account number: #{Settings.owner.bank.account_number}, "\
    "Sort Code: #{Settings.owner.bank.sort_code}"
  end

  def render_footer
    move_cursor_to 9
    font_size 9
    bounding_box([bounds.left, bounds.bottom], width: bounds.width, height: 30) do
      move_down 5
      text footer_text, inline_format: true
    end
  end

  def footer_text
    "#{Settings.owner.name}, Address: #{Settings.owner.address.join(', ')}, "\
      "UTR Number: #{Settings.owner.utr_number}\n"\
      "Web: <color rgb='007bff'><link href='#{Settings.owner.website}'>#{Settings.owner.website}</link></color>"
  end

  def asset_path(file_name)
    Rails.root.join('app').join('assets').join('pdf').join(file_name)
  end

  def invoice_items_data(invoice)
    data = [['Description', 'Quantity', 'Price', 'Amount']]
    invoice.invoice_items.each do |item|
      data.push [item.service.description, item.quantity, Utils.format_currency(item.service.price),
                 Utils.format_currency(item.value)]
    end
    data.push ['Total', '', { content: Utils.format_currency(invoice.total), colspan: 2 }]
    return data
  end
end
