class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :venue
  has_many :registrations
  has_many :reviews

  validates :title, presence: true
  validates :status, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :max_attendees, presence: true, numericality: { greater_than: 0 }
  
  validate :end_date_after_start_date

  enum :status, { draft: "draft", published: "published", cancelled: "cancelled", completed: "completed" }

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end