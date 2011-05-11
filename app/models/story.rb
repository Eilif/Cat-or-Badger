class Story < ActiveRecord::Base

  belongs_to :battle
  belongs_to :user

  validates_presence_of :story_text
  validates_presence_of :user
  validates_presence_of :battle

end
