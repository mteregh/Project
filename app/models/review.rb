class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :comment, presence: true
  validates :rating, presence: true,
            numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, only_integer: true }

  validates :user_id, uniqueness: {
    scope: :event_id,
    message: "ya dejó una reseña para este evento"
  }

  validate :event_must_be_completed

  validate :user_must_have_attended

  private

  def event_must_be_completed
    return if event.nil?
    unless event.completed?
      errors.add(:base, "Solo puedes reseñar eventos que ya han concluido")
    end
  end

  def user_must_have_attended
    return if event.nil? || user.nil?
    attended = event.registrations.exists?(user_id: user_id, status: "confirmed")
    unless attended
      errors.add(:base, "Solo los asistentes confirmados pueden dejar una reseña")
    end
  end
end