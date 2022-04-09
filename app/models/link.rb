class Link < ApplicationRecord
  belongs_to :user
  has_secure_token :short_url

  validates :short_url, uniqueness: true
  validates :long_url, presence: true
end
