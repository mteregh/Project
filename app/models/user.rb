class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :registrations
  has_many :reviews

  validates :name, :role, presence: true

  enum :role, { regular: "regular", admin: "admin" }
  
end