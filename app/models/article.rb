# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, :body, presence: true

  default_scope { order(created_at: :desc) }
end
