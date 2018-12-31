# frozen_string_literal: true

class InvoicePdf < Prawn::Document

  def initialize(invoice)
    super()
    image path('small-logo.png'), at: [367, 720], width: 120
    move_cursor_to 675
    text 'INVOICE', size: 36
    move_cursor_to 630
    text invoice.client.address.compact_lines.join("\n")
    formatted_text_box [
        {text: "Invoice Date\n", styles: [:bold]},
        {text: "#{invoice.issue_date.strftime("%d %b %Y")}\n\n"},
        {text: "Invoice Number\n", styles: [:bold]},
        {text: "#{invoice.invoice_id}\n\n"}
    ], at: [370, 630], width: 80, height: 100, size: 10
    text_box "#{Settings.owner.name}\n#{Settings.owner.address.join("\n")}",
        at: [470, 630], width: 70, height: 60, align: :right, size: 10
    move_cursor_to 500
    font_size 11
    number_of_items = invoice.invoice_items.size
    table(invoice_items_data(invoice), cell_style: {borders: [], padding: [4, 4, 4, 4]}) do
      columns(0).width = 360
      columns(1..3).align = :right
      columns(1..3).width = 60
      row(0).font_style = :bold
      row(0).borders = [:bottom]
      rows(1..number_of_items).borders = [:bottom]
      rows(1..number_of_items).border_width = 0.5
      rows(1..number_of_items).border_color = 'cccccc'
      row(number_of_items + 1).borders = [:top]
      row(number_of_items + 1).border_width = 1
      row(number_of_items + 1).border_color = '000000'
      row(number_of_items + 1).font_style = :bold
      row(number_of_items + 1).size = 16
    end
    move_down 40
    font_size 18
    text "Due Date: #{invoice.due_date.strftime("%d %B %Y")}", style: :bold
    move_down 12
    text 'PAYMENT ADVICE'
    font_size 11
    text "Electronic Payments: #{Settings.owner.bank.company}, "\
      "Account number: #{Settings.owner.bank.account_number}, "\
      "Sort Code: #{Settings.owner.bank.sort_code}"

    # Footer text
    move_cursor_to 9
    font_size 9
    bounding_box([bounds.left, bounds.bottom], width: bounds.width, height: 30) do
      move_down 5
      text "#{Settings.owner.name}, Address: #{Settings.owner.address.join(", ")}, "\
      "UTR Number: #{Settings.owner.utr_number}\n"\
      "Web: <color rgb='007bff'><link href='#{Settings.owner.website}'>#{Settings.owner.website}</link></color>",
          inline_format: true
    end
  end

  private

  def path(file_name)
    Rails.root.join('app').join('assets').join('pdf').join(file_name)
  end

  def invoice_items_data(invoice)
    data = [['Description', 'Quantity', 'Price', 'Amount']]
    total = 0
    invoice.invoice_items.each do |item|
      total += item.quantity * item.service.price
      data.push [item.service.description, item.quantity, Utils.format_currency(item.service.price),
          Utils.format_currency(item.service.price * item.quantity)]
    end
    data.push ['Total', '', {content: Utils.format_currency(total), colspan: 2}]
    return data
  end
end