class Venue < ApplicationRecord
  has_many :events

  validates :name, presence: true
  validates :location, presence: true
  validates :capacity, numericality: { greater_than: 0, allow_nil: true }
end