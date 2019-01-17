# frozen_string_literal: true

# Abstract class for model objects to allow code sharing.
class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true
end
