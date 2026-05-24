Review.destroy_all
Registration.destroy_all
Event.destroy_all
Category.destroy_all
Venue.destroy_all
User.destroy_all

users = [
  { name: "Tere Guerra", email: "tere@example.com", role: "admin" },
  { name: "Juan Perez", email: "juan@example.com", role: "student" },
  { name: "Maria Lopez", email: "maria@example.com", role: "student" },
  { name: "Pedro Pascal", email: "pedro@example.com", role: "faculty" },
  { name: "Anita Tijoux", email: "anita@example.com", role: "student" }
].map { |u| User.create!(u) }

categories = [
  { name: "Workshops", description: "Educational workshops" },
  { name: "Sports", description: "Physical activities" },
  { name: "Social", description: "Meetups and gatherings" }
].map { |c| Category.create!(c) }

venues = [
  { name: "Main Hall", location: "Campus Center", capacity: 100 },
  { name: "Gym", location: "Sports Complex", capacity: 50 },
  { name: "Room A", location: "Building 1", capacity: 30 }
].map { |v| Venue.create!(v) }

event_pub = Event.create!(
  title: "Ruby on Rails Workshop", description: "Learn Rails basics", status: "published",
  start_date: 2.days.from_now, end_date: 2.days.from_now + 2.hours,
  max_attendees: 30, user: users[0], category: categories[0], venue: venues[2]
)

event_draft = Event.create!(
  title: "Secret Admin Meeting", description: "Planning next semester", status: "draft",
  start_date: 5.days.from_now, end_date: 5.days.from_now + 2.hours,
  max_attendees: 20, user: users[0], category: categories[2], venue: venues[2]
)

event_ongoing = Event.create!(
  title: "Campus Hackathon", description: "Coding 24/7", status: "ongoing",
  start_date: 1.hour.ago, end_date: 1.day.from_now,
  max_attendees: 50, user: users[3], category: categories[0], venue: venues[0]
)

event_completed = Event.create!(
  title: "Football Final Match", description: "Great game!", status: "completed",
  start_date: 5.days.ago, end_date: 5.days.ago + 2.hours,
  max_attendees: 3, 
  user: users[0], category: categories[1], venue: venues[1]
)

event_cancelled = Event.create!(
  title: "Outdoor Picnic", description: "Cancelled due to rain", status: "cancelled",
  start_date: 1.day.from_now, end_date: 1.day.from_now + 4.hours,
  max_attendees: 100, user: users[3], category: categories[2], venue: venues[0]
)

Registration.create!(user: users[1], event: event_pub, status: "confirmed", registered_at: Time.current)
Registration.create!(user: users[2], event: event_pub, status: "confirmed", registered_at: Time.current)

Registration.create!(user: users[1], event: event_completed, status: "confirmed", registered_at: Time.current - 6.days)
Registration.create!(user: users[2], event: event_completed, status: "confirmed", registered_at: Time.current - 6.days)
Registration.create!(user: users[4], event: event_completed, status: "confirmed", registered_at: Time.current - 6.days)
Registration.create!(user: users[3], event: event_completed, status: "pending", registered_at: Time.current - 5.days)

Review.create!(rating: 5, comment: "Amazing match, so much fun!", user: users[1], event: event_completed)
Review.create!(rating: 4, comment: "Good, but the referee was blind.", user: users[2], event: event_completed)
Review.create!(rating: 5, comment: "Best event of the year.", user: users[4], event: event_completed)

puts "¡Semillas creadas con éxito! Datos listos y representativos."