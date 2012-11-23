class Screwconnector < ActiveRecord::Base
  belongs_to :screwer, :class_name => "DummyUser" # Person screwing
  belongs_to :screw, :class_name => "User" # Person being screwed
  # The screw with whom this screw was matched, if any (default is 0, i.e. unmatched)
  belongs_to :match, :class_name => "Screwconnector" 

  has_many :sent_requests, :class_name => "Request", :foreign_key => "from_id", :dependent => :delete_all
  has_many :got_requests, :class_name => "Request", :foreign_key => "to_id", :dependent => :delete_all

  validates_presence_of :event, :intensity, :screw_id, :screwer_id

  def cleanup
    # destroy all the pending requests from this screwconnector
    Request.where(from_id: self, accepted: nil).destroy_all 
    
    recd = Request.where(to_id: self, accepted: nil)
    recd.each do |r|
      r.accepted = false # Reject all the other requests sent to this sc
      r.save
    end
  end

  # returns an array of [screws, intensity, event, all]
  def find_everything
    # Differentiate between those which are being screwed (the screw of at least one screwconnector) and those who aren't
    # of the former, find those who haven't been matched for the event you're going for

    p = self.screw;
    my_id = session[:user_id]
    if p.preference == 3
      # Get all users matching preferences that aren't the screw him/herself or the screwer
      all = User.includes({:screwconnectors => :screw}, :screwers).where(["(preference = ? OR preference = 3) AND id <> ?", p.party, p.id]).order("updated_at DESC");
    else
      all = User.includes({:screwconnectors => :screw}, :screwers).where(["(preference = ? OR preference = 3) AND (party = ?) AND id <> ?", p.party, p.preference, p.id]).order("updated_at DESC");
    end
    all_screw_matches = [] # subset of all matches
    intensity_matches = [] # subset of all_screw matches
    event_matches = []     # subset of all_screw matches
    all_matches = []

    all.each do |a|
      # get all unmatched screwconnector objects in which a is the screw 
      sc = Screwconnector.includes(:screw).where(match_id: 0, screw_id: a.id).first
      if not sc  # the person is not being screwed or already matched
        all_matches.append({:type => "user", :match => a})
      else       # the person is being screwed and unmatched 
        # if the person isn't one of my other screws
        if sc.screwer_id != my_id 
          all_matches.append({:type => "sc", :match => sc})
          all_screw_matches.append(sc)
          intensity_matches.append(sc) if (sc.intensity - self.intensity).abs <= 2
          event_matches.append(sc) if (sc.event == self.event)

        # If they are one of my screws, they should still show up as a person
        elsif sc.event != self.event
          all_matches.append({:type => "user", :match => a})
        end
      end
    end

    return [all_screw_matches, intensity_matches, event_matches, all_matches]
  end
end
