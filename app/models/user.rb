class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { minimum: 4, maximum: 15 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def followers
    ActiveRecord::Base.connection.execute <<-SQL
      SELECT u2.id AS user_id, u2.name, u2.email FROM users u1 
      INNER JOIN followers ON u1.id = followers.followed_id
      INNER JOIN users u2 ON followers.follower_id = u2.id
      WHERE followers.followed_id = #{id}
    SQL
  end

  def followeds
    ActiveRecord::Base.connection.execute <<-SQL
      SELECT u2.id AS user_id, u2.name, u2.email FROM users u1 
      INNER JOIN followers ON u1.id = followers.follower_id
      INNER JOIN users u2 ON followers.followed_id = u2.id
      WHERE followers.follower_id = #{id}
    SQL
  end	
end
