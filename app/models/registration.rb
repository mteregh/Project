class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status, presence: true

  enum :status, { pending: "pending", confirmed: "confirmed", cancelled: "cancelled" }
end