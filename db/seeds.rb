puts "Seeding..."
users = [
  # Statesmen
  {
    fname: "Barack",
    lname: "Obama",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Official_portrait_of_Barack_Obama.jpg/220px-Official_portrait_of_Barack_Obama.jpg",
    party: 2,
    preference: 1,
    profession: "POTUS"
  },
  {
    fname: "Michelle",
    lname: "Obama",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Michelle_Obama_official_portrait_headshot.jpg/225px-Michelle_Obama_official_portrait_headshot.jpg",
    party: 2,
    preference: 1,
    profession: "First Lady"
  },
  {
    fname: "Joe",
    nickname: "Bidenator",
    lname: "Biden",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Joe_Biden_official_portrait_crop.jpg/220px-Joe_Biden_official_portrait_crop.jpg",
    party: 2,
    preference: 2,
    profession: "VPOTUS, White House Bro"
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
    fname: "Bill",
    lname: "Clinton",
    nickname: "Ladykiller",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Bill_Clinton.jpg/220px-Bill_Clinton.jpg",
    party: 2,
    preference: 3,
    profession: "Former POTUS, Democratic Campaign Machine"
  },
  {
    fname: "Hillary",
    lname: "Clinton",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Hillary_Clinton_official_Secretary_of_State_portrait_crop.jpg/220px-Hillary_Clinton_official_Secretary_of_State_portrait_crop.jpg",
    party: 2,
    preference: 3,
    profession: "Secretary of State, Former First Lady, A symbol for women everywhere"
  },
  {
    fname: "George",
    lname: "Bush",
    nickname: "Dubya",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/George-W-Bush.jpeg/220px-George-W-Bush.jpeg",
    party: 1,
    preference: 1,
    profession: "Former POTUS, ...too many jokes to make here"
  },
  {
    fname: "Dick",
    lname: "Cheney",
    nickname: "Shotgun",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/8/88/46_Dick_Cheney_3x4.jpg/220px-46_Dick_Cheney_3x4.jpg",
    party: 1,
    preference: 1,
    profession: "Former VPOTUS, Destroyer of Worlds"
  },
  {
    fname: "Newt",
    lname: "Gingrich",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Newt_Gingrich_by_Gage_Skidmore_6.jpg/220px-Newt_Gingrich_by_Gage_Skidmore_6.jpg",
    party: 1,
    preference: 1,
    profession: "Former Speaker of the House, a newt"
  },
  {
    fname: "Nancy",
    lname: "Pelosi",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Speaker_Nancy_Pelosi.jpg/220px-Speaker_Nancy_Pelosi.jpg",
    party: 2,
    preference: 2,
    profession: "U.S. House Minority Leader, 1st female Speaker"
  },

  # Media
  {
    fname: "Rush",
    lname: "Limbaugh",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Limbaugh_Award_cropped.jpg/180px-Limbaugh_Award_cropped.jpg",
    party: 1,
    preference: 1,
    profession: "Talk Show Host, Instigator, 3-time divorcee"
  },
  {
    fname: "Kieth",
    lname: "Olbermann",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Keith_Olbermann-1.jpg/220px-Keith_Olbermann-1.jpg",
    party: 2,
    preference: 2,
    profession: "Political commentator, Campaign contributor"
  },
  {
    fname: "Bill",
    lname: "O'Reilly",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Bill_O%27Reilly_at_the_World_Affairs_Council_of_Philadelphia_%28cropped%29.jpg/220px-Bill_O%27Reilly_at_the_World_Affairs_Council_of_Philadelphia_%28cropped%29.jpg",
    party: 1,
    preference: 1,
    profession: "Political commentator, Self-proclaimed 'Independent'"
  },
  {
    fname: "Rachel",
    lname: "Maddow", 
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Rachel_Maddow_in_Seattle_cropped.png/220px-Rachel_Maddow_in_Seattle_cropped.png",
    party: 2, 
    preference: 2,
    profession: "Commentator, First openly gay anchor of a major US primetime news show!"
  },
  {
    fname: "Glenn",
    lname: "Beck",
    picture: "http://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Glenn_Beck_by_Gage_Skidmore_3.jpg/220px-Glenn_Beck_by_Gage_Skidmore_3.jpg",
    party: 1, 
    preference: 1, 
    profession: "Television host, Defender of Israel and American Values"
  },
  {
    fname: "Jon",
    lname: "Stewart",
    picture: "http://bpr.berkeley.edu/wordpress/wp-content/uploads/2011/06/jon-stewart.jpg",
    party: 2,
    preference: 3,
    profession: "Political satirist, Champion of sanity"
  },
  {
    fname: "Steven",
    lname: "Colbert",
    picture: "http://img2-2.timeinc.net/ew/dynamic/imgs/070304/172430__colbert_l.jpg",
    party: 1,
    preference: 3,
    profession: "Political satirist, The Republican-est"
  }

  
]

users.each do |u|
  u[:nickname] = u[:fname] unless u[:nickname]
  User.create(u)
end

puts "Done!"
