# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  validates :title, :body, presence: true
  has_many :comments, dependent: :destroy

  default_scope { order(created_at: :desc) }
end
