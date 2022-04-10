# frozen_string_literal: true

class Link < ApplicationRecord
  belongs_to :user
  has_secure_token

  validates :long_url, presence: true

  scope :sorted_by_created_at, -> { order(:created_at) }

  def short_url
    "not implemented yet #{token}"
  end
end
