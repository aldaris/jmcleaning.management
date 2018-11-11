module ApplicationHelper
  def active_class(link_path)
    request.path.start_with?(link_path) ? 'nav-item nav-link active' : 'nav-item nav-link'
  end
end
