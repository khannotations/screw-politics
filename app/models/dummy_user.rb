class DummyUser < ActiveRecord::Base
  # connectors in which user is screwer
  has_many :screwconnectors, :foreign_key => "screwer_id"
end
