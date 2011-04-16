class Contention < ActiveRecord::Base

  validates_presence_of :animal
  validates_presence_of :battle

  belongs_to :battle
  belongs_to :animal

end
