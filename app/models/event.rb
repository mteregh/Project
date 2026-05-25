class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :venue
  has_many :registrations
  has_many :reviews

  has_rich_text :description

  validates :title, presence: true
  validates :status, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :max_attendees, presence: true, numericality: { greater_than: 0, only_integer: true }

  validate :end_date_after_start_date

  enum :status, {
    draft: "draft",
    published: "published",
    ongoing: "ongoing",
    completed: "completed",
    cancelled: "cancelled"
  }

  def confirmed_count
    registrations.confirmed.count
  end

  def available_spots
    max_attendees - confirmed_count
  end

  def full?
    available_spots <= 0
  end

  def publish!
    update!(status: :published) if draft?
  end

  def cancel!
    return unless draft? || published?

    transaction do
      registrations.where(status: %w[confirmed waitlisted]).update_all(status: "cancelled")
      update!(status: :cancelled)
    end
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "debe ser posterior a la fecha de inicio")
    end
  end
end