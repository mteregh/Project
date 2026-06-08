Review.destroy_all
Registration.destroy_all
Event.destroy_all
Category.destroy_all
Venue.destroy_all
User.destroy_all

puts "Creating users..."

admin = User.create!(
  name: "Admin User",
  email: "admin@eventhub.com",
  password: "password123",
  password_confirmation: "password123",
  role: "admin"
)

user1 = User.create!(
  name: "John Smith",
  email: "john@eventhub.com",
  password: "password123",
  password_confirmation: "password123",
  role: "regular"
)

user2 = User.create!(
  name: "Emma Johnson",
  email: "emma@eventhub.com",
  password: "password123",
  password_confirmation: "password123",
  role: "regular"
)

user3 = User.create!(
  name: "Michael Brown",
  email: "michael@eventhub.com",
  password: "password123",
  password_confirmation: "password123",
  role: "regular"
)

puts "Creating categories..."

technology = Category.create!(name: "Technology")
sports = Category.create!(name: "Sports")
education = Category.create!(name: "Education")

puts "Creating venues..."

venue1 = Venue.create!(
  name: "Main Auditorium",
  location: "Santiago Campus",
  capacity: 200
)

venue2 = Venue.create!(
  name: "Innovation Center",
  location: "Providencia",
  capacity: 120
)

venue3 = Venue.create!(
  name: "Sports Complex",
  location: "Las Condes",
  capacity: 300
)

puts "Creating events..."

event1 = Event.create!(
  title: "Ruby on Rails Workshop",
  description: "Introductory workshop about Ruby on Rails.",
  category: technology,
  venue: venue1,
  user: user1,
  start_date: 5.days.from_now,
  end_date: 5.days.from_now + 3.hours,
  max_attendees: 50,
  status: "published"
)

event2 = Event.create!(
  title: "Basketball Tournament",
  description: "Friendly basketball tournament for students.",
  category: sports,
  venue: venue3,
  user: user2,
  start_date: 10.days.from_now,
  end_date: 10.days.from_now + 6.hours,
  max_attendees: 100,
  status: "published"
)

event3 = Event.create!(
  title: "Study Skills Seminar",
  description: "Seminar about study strategies and productivity.",
  category: education,
  venue: venue2,
  user: user3,
  start_date: 2.days.ago,
  end_date: 1.day.ago,
  max_attendees: 40,
  status: "completed"
)

puts "Creating registrations..."

Registration.create!(
  user: user2,
  event: event1,
  status: "confirmed",
  registered_at: Time.current
)

Registration.create!(
  user: user3,
  event: event1,
  status: "confirmed",
  registered_at: Time.current
)

Registration.create!(
  user: user1,
  event: event3,
  status: "confirmed",
  registered_at: 2.days.ago
)

Registration.create!(
  user: user2,
  event: event3,
  status: "confirmed",
  registered_at: 2.days.ago
)

puts "Creating reviews..."

Review.create!(
  user: user1,
  event: event3,
  rating: 5,
  comment: "Excellent event with great content."
)

Review.create!(
  user: user2,
  event: event3,
  rating: 4,
  comment: "Very useful and well organized."
)

puts "Seed data created successfully."
puts ""
puts "TEST ACCOUNTS"
puts "Admin: admin@eventhub.com / password123"
puts "User: john@eventhub.com / password123"
puts "User: emma@eventhub.com / password123"
puts "User: michael@eventhub.com / password123"