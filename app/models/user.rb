class User < ApplicationRecord
  has_many :events
  has_many :registrations
  has_many :reviews

  validates :name, :email, :role, presence: true
  validates :email, uniqueness: true

  enum :role, { student: "student", faculty: "faculty", admin: "admin" }
end