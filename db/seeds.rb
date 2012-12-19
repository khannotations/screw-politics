puts "Seeding..."
users = [
  # Head of state
  {
    fname: "Barack",
    lname: "Obama",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Official_portrait_of_Barack_Obama.jpg/220px-Official_portrait_of_Barack_Obama.jpg",
    party: 2,
    preference: 1,
    profession: "POTUS"
  },
  {
    fname: "Michele",
    lname: "Obama",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Michelle_Obama_official_portrait_headshot.jpg/225px-Michelle_Obama_official_portrait_headshot.jpg",
    party: 2,
    preference: 1,
    profession: "First Lady"
  },
  {
    fname: "John",
    lname: "Boehner",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/John_Boehner_official_portrait.jpg/220px-John_Boehner_official_portrait.jpg",
    party: 1, 
    preference: 3,
    profession: "Speaker of the House"
  },
  {
    fname: "Rush",
    lname: "Limbaugh",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Limbaugh_Award_cropped.jpg/180px-Limbaugh_Award_cropped.jpg",
    party: 1,
    preference: 1,
    profession: "Talk Show Host, Instigator, 3-time divorcee"
  }

  # Media
]

users.each do |u|
  u[:nickname] = u[:fname] unless u[:nickname]
  User.create(u)
end

puts "Done!"
