class Link < ApplicationRecord
  belongs_to :user
  has_secure_token

  validates :long_url, presence: true
end
