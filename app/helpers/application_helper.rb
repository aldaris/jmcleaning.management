module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? 'nav-item nav-link active' : 'nav-item nav-link'
  end
end
