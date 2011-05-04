class Vote < ActiveRecord::Base

  belongs_to :animal
  belongs_to :battle
  belongs_to :user

  validates_presence_of :animal
  validates_presence_of :battle
  validates_presence_of :weight
  validate :right_weight

  def right_weight
    unless weight == 1 or weight == 10
      errors.add(:weight, "weight must be 1 or 10")
    end
  end

end
