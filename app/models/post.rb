class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :content, presence: true
  validates :spotify_track_id, presence: true
end
