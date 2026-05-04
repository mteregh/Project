class User < ApplicationRecord
  has_many :events
  has_many :registrations
  has_many :reviews

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  enum :role, { student: "student", faculty: "faculty", admin: "admin" }
end