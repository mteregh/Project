class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status, presence: true

  enum :status, {
    pending: "pending",
    confirmed: "confirmed",
    waitlisted: "waitlisted",
    cancelled: "cancelled"
  }

  validates :user_id, uniqueness: {
    scope: :event_id,
    message: "ya está registrado en este evento"
  }

  validate :event_must_be_published, on: :create

  private

  def event_must_be_published
    return if event.nil?
    unless event.published?
      errors.add(:base, "Solo puedes registrarte en eventos publicados")
    end
  end
end