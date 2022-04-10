# frozen_string_literal: true

class Link < ApplicationRecord
  belongs_to :user
  has_secure_token

  validates :long_url, presence: true

  scope :sorted_by_created_at, -> { order(:created_at) }

  def short_url
    Rails.application.routes.url_helpers.shorten_url token: token
  end

  def clicked_count_increasing!
    update!(clicked_count: clicked_count + 1)
  end
end
