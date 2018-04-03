class User < ApplicationRecord
  has_secure_password
  has_many :links, dependent: :destroy
  has_many :comments
  has_many :votes
  
  validates :username,
            presence: true,
            length: { minimum: 3 },
            uniqueness: { case_sensitive: false }
   
  validates :password, length: { minimum: 8 }

  def owns_link?(link)
  self == link.user
  end

  def owns_comment?(comment)
  self == comment.user
end

end
