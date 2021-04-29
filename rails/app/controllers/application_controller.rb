# frozen_string_literal: true

# Application level controller for code sharing purposes.
class ApplicationController < ActionController::Base
  rescue_from ActionController::ParameterMissing do
    head :bad_request, content_type: 'text/html'
  end
end
