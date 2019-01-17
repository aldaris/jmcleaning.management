# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActionController::ParameterMissing do
    head :bad_request, content_type: 'text/html'
  end
end
