class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :received_friendships, foreign_key: :receiver_id, class_name: "Friendship"
  has_many :asked_friendships, foreign_key: :asker_id, class_name: "Friendship"

  has_many :received_friends, through: :received_friendships, source: 'asker'
  has_many :asked_friends, through: :asked_friendships, source: 'receiver'

  has_many :posts
  has_many :favorites, through: :posts, dependent: :destroy
  has_one_attached :photo

  def friends
    received_friends.where(friendships: { status: 2 }) + asked_friends.where(friendships: { status: 2 })
  end

  def pending_friends
    received_friends.where(friendships: { status: 1 }) + asked_friends.where(friendships: { status: 1 })
  end

  def self.from_omniauth(auth)
    if User.find_by(email: auth.info.email)
      User.find_by(email: auth.info.email).update(provider: auth.provider, uid: auth.uid)
      user = User.find_by(email: auth.info.email)
    else
      user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.save
    end
    user
  end

  # UPDATED ASSOCIATION ABOVE + METHOD BELOW TO CHECK IF USER HAS LIKED A GIVEN POST AND RETURN THE LIKE RECORD
  # ASSOCIATED WITH THE POST AND THE USER:
  def favorites?(post)
    favorites.exists?(post_id: post.id)
  end

  def favorites_for(post)
    favorites.find_by(post_id: post.id)
  end
end
