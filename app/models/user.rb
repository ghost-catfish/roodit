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

  def upvote
    link = Link.find_by(id: params[:id])

    if current_user.upvoted?(link)
      current_user.remove_vote(link)
    else
      current_user.upvote(link)
    end

    redirect_to root_path
  end

  def upvoted?(link)
  votes.exists?(upvote: 1, link: link)
  end

  def remove_vote(link)
  votes.find_by(link: link).destroy
  end

  def downvote(link)
  votes.create(downvote: 1, link: link)
  end

  def downvoted?(link)
  votes.exists?(downvote: 1, link: link)
  end

end
