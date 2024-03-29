class Friendship < ApplicationRecord
  belongs_to :asker, class_name: "User", foreign_key: "asker_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  validates :asker_id, presence: true
  validates :receiver_id, presence: true
  validates :asker_id, uniqueness: { scope: :receiver_id }
  validate :not_self_friending

  enum status: { requested: 1, accepted: 2, rejected: 3 }

  def not_self_friending
    if asker_id == receiver_id
      errors.add(:receiver_id, "can't be the same as asker")
    end
  end
end
