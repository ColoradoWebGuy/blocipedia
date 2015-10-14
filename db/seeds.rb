
# Create Users
5.times do
   u = User.new(
    email:    Faker::Internet.email,
    password: Faker::Internet.password
  )
  u.skip_confirmation!
  u.save
end
users = User.all

# Create Wikis
50.times do
 # #1
   Wiki.create!(
 # #2
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph(2, true),
     private: false,
     user: users.sample
   )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
