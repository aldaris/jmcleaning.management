# frozen_string_literal: true

ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT) if Rails.env.development?
