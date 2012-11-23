class User < ActiveRecord::Base
  require 'net/ldap'
  require 'mechanize'

  # has_many :screwconnectors, :foreign_key => "screw_id" # connectors in which user is screw

  # has_many :screwers, :through => :screwconnectors # People screwing user
  # has_many :screws, :through => :screwerconnectors # People user is screwing

  has_many :got_requests, :through => :screwerconnectors
  has_many :sent_requests, :through => :screwerconnectors

  validates :fname, :presence => true
  validates :lname, :presence => true
  validates :email, :presence => true, :uniqueness => {:case_sensitive => false, :message => "Must have unique email"}


  # CLASS VARIABLES

  @@people = []

  @@events = {
    :sanity => "Rally to Restore Sanity", 
    :fear => "Rally to Keep Fear Alive"
  }


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

  def fullname
    "#{self.nickname} #{self.lname}"
  end

  def lengthy_name
    part = ""
    if self.nickname != self.fname
      "#{self.fname} \"#{self.nickname}\" #{self.lname}"
    else
      self.fullname
    end
  end

  # Should be in helper, but couldn't get it to work and gave up
  def make_select
    text = 
    "<select name='event'>\
    <option value='#{college} Screw 2012'>#{college} 2012</option>"
    if self.year == "'15"
      text += "<option value='Freshman Screw 2013'>Freshman 2013</option>"
    end
    text += "</select>"
    text
  end

  # Stringify the preference
  def pref
    p = self.preference
    return "Conservatives" if p == 1
    return "Liberals" if p == 2
    return "Conservatives and Liberals (aka isn't real)" if p == 3
    return "other lames"
  end

  # Stringify the gender
  def gen
    g = self.gender
    return "Conservative" if g == 1
    return "Liberal" if g == 2
    return "lame" # Sass in case they bypassed gender specs
  end


  def User.make_names
    @@people = []
    User.all.each do |u|
      @@people << u.lengthy_name
    end
    return
  end

  def User.all_names
    @@people
  end

  # Gets the user from the lengthy name, the inverse of lengthy name
  def User.identify name
    college_year_regex = / \((\w\w) '(\d\d)\)/
    nickname_regex = /"(\w|-)+"/

    cy = college_year_regex.match(name)
    return nil if not cy
    college = User.long_college cy[1]
    year = "20"+cy[2]

    name = name.gsub(college_year_regex, "") # Remove college, year junk  
    name = name.gsub(nickname_regex, "").split(" ")

    # Now 'name' is an array 
    fname = name[0]
    lname = name[1, 5].join(" ") # the rest — not sure why i chose 5?

    @user = User.where(fname: fname, lname: lname, college: college, year: year).first

  end

  # SETUP 
  User.make_names


end
