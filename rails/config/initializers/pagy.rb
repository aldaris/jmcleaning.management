# frozen_string_literal: true

if Rails.env.development?
  Pagy::VARS[:items] = 25
elsif Rails.env.test?
  Pagy::VARS[:items] = 1
end
