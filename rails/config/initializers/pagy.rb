# frozen_string_literal: true

if Rails.env.test?
  Pagy::VARS[:items] = 1
else
  Pagy::VARS[:items] = 22
end
