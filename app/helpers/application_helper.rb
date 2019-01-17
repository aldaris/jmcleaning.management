# frozen_string_literal: true

# Contains application wide helper methods for the view.
module ApplicationHelper

  def active_class(link_path)
    if (request.path == '/' && link_path == invoices_path) || request.path.start_with?(link_path)
      'nav-item nav-link active'
    else
      'nav-item nav-link'
    end
  end
end
