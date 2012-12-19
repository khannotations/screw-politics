class User < ActiveRecord::Base

  validates_presence_of :fname, :lname

  # CLASS VARIABLES

  @@people = []

  @@events = {
    :sanity => "Rally to Restore Sanity", 
    :fear => "Rally to Keep Fear Alive",
    :sou => "State of the Union",
    :elections => "2016 Elections"
  }

  def fullname
    "#{self.nickname} #{self.lname}"
  end

  def lengthy_name
    if self.nickname != self.fname
      "#{self.fname} \"#{self.nickname}\" #{self.lname}"
    else
      self.fullname
    end
  end

  # Should be in helper, but couldn't get it to work and gave up
  def make_select
    text = "<select name='event'>"
    @@events.each do |key, val|
      text+= "<option value='#{key}'>#{val}</option>"
    end
    text += "</select>"
    text
  end

  # Stringify the preference
  def pref
    p = self.preference
    return "Conservatives" if p == 1
    return "Liberals" if p == 2
    return "Conservatives and Liberals (how novel!)" if p == 3
    return "other lames"
  end

  # Stringify the gender
  def par
    g = self.party
    return "Conservative" if g == 1
    return "Liberal" if g == 2
    return "lame" # Sass in case they bypassed gender specs
  end

  
  def User.get_event key
    @@events[key.to_sym]
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
    nickname_regex = /"(\w|-)+"/
    name = name.gsub(nickname_regex, "").split(" ")
    # Now 'name' is an array 
    fname = name[0]
    lname = name[1]
    User.where(fname: fname, lname: lname).first
  end

  # SETUP 
  User.make_names

end
