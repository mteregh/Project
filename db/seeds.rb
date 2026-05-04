Review.destroy_all
Registration.destroy_all
Event.destroy_all
Category.destroy_all
Venue.destroy_all
User.destroy_all

users = [
  { name: "Tere Guerra", email: "tere@example.com", role: "admin" },     # <-- Cambiado a admin
  { name: "Juan Perez", email: "juan@example.com", role: "student" },    # <-- Cambiado a student
  { name: "Maria Lopez", email: "maria@example.com", role: "student" }   # <-- Cambiado a student
]
users = users.map { |u| User.create!(u) }

categories = [
  { name: "Workshops", description: "Educational workshops" },
  { name: "Sports", description: "Physical activities" },
  { name: "Social", description: "Meetups and gatherings" }
]
categories = categories.map { |c| Category.create!(c) }

venues = [
  { name: "Main Hall", location: "Campus Center", capacity: 100 },
  { name: "Gym", location: "Sports Complex", capacity: 50 },
  { name: "Room A", location: "Building 1", capacity: 30 }
]
venues = venues.map { |v| Venue.create!(v) }

event1 = Event.create!(
  title: "Ruby on Rails Workshop",
  description: "Learn Rails basics",
  status: "published",                                                   # <-- Cambiado a published
  start_date: 2.days.from_now,
  end_date: 2.days.from_now + 2.hours,
  max_attendees: 30,
  user: users[0],
  category: categories[0],
  venue: venues[2]
)

event2 = Event.create!(
  title: "Football Match",
  description: "Friendly match",
  status: "draft",                                                       # <-- Cambiado a draft para tener distintas etapas
  start_date: 3.days.from_now,
  end_date: 3.days.from_now + 2.hours,
  max_attendees: 20,
  user: users[0],
  category: categories[1],
  venue: venues[1]
)

Registration.create!(
  user: users[1],
  event: event1,
  status: "confirmed",
  registered_at: Time.current
)

Registration.create!(
  user: users[2],
  event: event1,
  status: "confirmed",
  registered_at: Time.current
)

Registration.create!(
  user: users[1],
  event: event2,
  status: "pending",
  registered_at: Time.current
)

Review.create!(
  rating: 5,
  comment: "Great event!",
  user: users[1],
  event: event1
)

Review.create!(
  rating: 4,
  comment: "Very fun!",
  user: users[2],
  event: event1
)

puts "Seeds created successfully!"