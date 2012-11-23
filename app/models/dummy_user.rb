class DummyUser < ActiveRecord::Base
  # connectors in which user is screwer
  has_many :screwconnectors, :foreign_key => "screwer_id"

  has_many :screws, :through => :screwconnectors
  has_many :got_requests, :through => :screwerconnectors
  has_many :sent_requests, :through => :screwerconnectors

  @@words = %w(
    Hullabaloo Sponge Idiopathic Bobbin Bamboo Poppycock 
    Persnickety Irked Queer Flabbergasted Frippery Befuddlement 
    Haberdashery Diphthong Britches Scrumptious Sassafras Gadabouts 
    Bazooka Cockamamie Egad Frumpy Claptrap Pooch Sack Sag Baffled 
    Bubbles Noodles Flagellum Blimp Napkin Jiggle Discombobulate 
    Fallopian Pants Follicle Box Bladder Spoon Centipede Indubitably 
    Banana Igloo Waddle Wobble Sludge Briefs Trump Gristle Sprout 
    Turnip Gash Sandals Crunch Turd Gauze Goon Manhole Cockamamie 
    Noddle Pudding Strudel Rubbish Duty Guava Smashing Hunky Inevitable 
    Inedible Goon Doughnut Chicken Pickle Bubbles Blubber Sickle 
    Miscellaneous Flagella Cilia Tweezers Jiggle Pregnant Hippo Blubber 
    Fig Floppy Peduncle Fat Bum Perpendicular Ninja Flannel Graze Gullet 
    Lozenge Topple Scribble Magma Bulbous Spatula Machete Cougar Rice Cheese 
    Fillet Bacon Truffles Scruffy Sausage Bowl Flabbergasted Haberdashery 
    Shenanigans Pop Termites Ding Feline Canine Rustic Crook Reservoir Face 
    Booty Pony Snap Rear Moose Cashew Rummage)

  # All sent requests
  def get_sent
    self.sent_requests.includes({:to => :screw}, {:from => :screw}).where(accepted: nil).order("to_id")
  end

  # All received requests
  def get_got
    self.got_requests.includes({:to => :screw}, {:from => :screw}).where(accepted: nil).order("to_id")
  end

  def get_past_sent
    self.sent_requests.includes({:to => :screw}, {:from => :screw}).where("accepted = ? OR accepted = ?", true, false).order("updated_at DESC")
  end

  def get_past_got
    self.got_requests.includes({:to => :screw}, {:from => :screw}).where("accepted = ? OR accepted = ?", true, false).order("updated_at DESC")
  end

  def DummyUser.create_user
    two = @@words.sample 2
    name = two[0]+"-"+two[1]
    u = DummyUser.create!({
      name: name
    })
    u
  end
end
