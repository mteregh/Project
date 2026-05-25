class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events
  has_many :registrations
  has_many :reviews

  validates :name, :role, presence: true

  enum :role, { student: "student", faculty: "faculty", admin: "admin" }
end