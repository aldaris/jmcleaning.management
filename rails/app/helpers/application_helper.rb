# frozen_string_literal: true

# Contains application wide helper methods for the view.
module ApplicationHelper
  include Pagy::Frontend

  def active_class(link_path)
    if (request.path == '/' && link_path == invoices_path) || request.path.start_with?(link_path)
      'nav-item nav-link active'
    else
      'nav-item nav-link'
    end
  end

  # Pagination for bootstrap: it returns the html with the series of links to the pages
  def pagy_bootstrap_nav(pagy)
    html = +''
    link = pagy_link_proc(pagy, 'class="page-link"')
    p_prev = pagy.prev
    p_next = pagy.next

    add_prev_button(html, link, p_prev)
    add_pagy_series(html, link, pagy)
    add_next_button(html, link, p_next)
    %(<nav class="pagy-nav-bootstrap pagy-bootstrap-nav" role="navigation" aria-label="pager">
        <ul class="pagination justify-content-center">#{html}</ul></nav>)
  end

  private

  def add_prev_button(html, link, p_prev)
    html << (
    if p_prev
      %(<li class="page-item prev">#{link.call p_prev, pagy_t('pagy.nav.prev'), 'aria-label="previous"'}</li>)
    else
      %(<li class="page-item prev disabled"><a href="#" class="page-link">#{pagy_t('pagy.nav.prev')}</a></li>)
    end)
  end

  def add_pagy_series(html, link, pagy)
    pagy.series.each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
      html << if item.is_a?(Integer)
                %(<li class="page-item">#{link.call item}</li>)
              elsif item.is_a?(String)
                %(<li class="page-item active">#{link.call item}</li>)
              elsif item == :gap
                %(<li class="page-item gap disabled"><a href="#" class="page-link">#{pagy_t('pagy.nav.gap')}</a></li>)
              end
    end
  end

  def add_next_button(html, link, p_next)
    html << (
    if p_next
      %(<li class="page-item next">#{link.call p_next, pagy_t('pagy.nav.next'), 'aria-label="next"'}</li>)
    else
      %(<li class="page-item next disabled"><a href="#" class="page-link">#{pagy_t('pagy.nav.next')}</a></li>)
    end)
  end
end
