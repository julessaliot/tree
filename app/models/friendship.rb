class Friendship < ApplicationRecord
  belongs_to :asker, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :asker_id, presence: true
  validates :receiver_id, presence: true
  validates :asker_id, uniqueness: { scope: :receiver_id }
  validate :not_self_friending
  validate :request_not_sent_twice

  def not_self_friending
    if asker_id == receiver_id
      errors.add(:receiver_id, "can't be the same as asker")
    end
  end

  def request_not_sent_twice
    if Friendship.exists?(asker_id: asker_id, receiver_id: receiver_id)
      errors.add(:asker_id, "friendship request already sent")
    end
  end
end
