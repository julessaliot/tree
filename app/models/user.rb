class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  # has_many :posts
  # has_many :friendships_as_asker, class_name: "Friendship", foreign_key: :asker_id
  # has_many :friendships_as_receiver, class_name: "Friendship", foreign_key: :receiver_id
  # has_many :favorites, through: :posts
  # has_many :comments, through: :posts

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

end
