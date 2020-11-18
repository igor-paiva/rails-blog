class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy

  has_many :followers, foreign_key: :follower_id, dependent: :destroy
  has_many :followeds, class_name: 'Follower', foreign_key: :followed_id, dependent: :destroy

  has_many :follower_users, through: :followers, foreign_key: :follower_id, source: :follower
  has_many :followed_users, through: :followers, foreign_key: :followed_id, source: :followed

  validates :name, presence: true, length: { minimum: 4, maximum: 15 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def follower_users
    ActiveRecord::Base.connection.execute <<-SQL
      SELECT users.id, users.name, users.email
      FROM users INNER JOIN followers
      ON users.id = followers.follower_id
      WHERE followers.followed_id = #{id}
    SQL
  end
end
