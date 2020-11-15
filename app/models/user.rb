class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { minimum: 4, maximum: 15 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
