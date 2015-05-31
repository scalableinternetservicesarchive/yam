# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create 1000 users and games
100000.times do |n|
  User.create!(id: n, email: "test#{n}@test.com", password: 'password', password_confirmation: 'password')
  # puts "Created user: test#{n}@test.com"

  Game2048.create(pid1: n, pid2: n + 1,
                    board1: "1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0", 
                    board2: "1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0", 
                    player1turn: true)
  # puts "Created a Game2048 match"
end
puts "Number of users: #{User.count}"