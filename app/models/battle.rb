class Battle < ActiveRecord::Base

  belongs_to :animal_1, :class_name => "Animal"
  belongs_to :animal_2, :class_name => "Animal"

  validates_presence_of :animal_1
  validates_presence_of :animal_2

  has_many :votes

  def vote_for(animal_id)
    if animal_id.to_i == animal_1_id
      Vote.create(:battle => self, :animal => animal_1)
    elsif animal_id.to_i == animal_2_id
      Vote.create(:battle => self, :animal => animal_2)
    end
  end

  def tally_votes
    Vote.find(:animal_id => self.animal_1_id).each do |a1|
      animal_1_score = a1.weight.increment!
    end

    Vote.find(:animal_id => self.animal_2_id).each do |a2|
      animal_2_score = a2.weight.increment!
    end
  end

  def declare_outcome
    if animal_1_score > animal_2_score
      self.animal_1.name + " wins!"
    elsif animal_2_score > animal_1_score
      self.animal_2.name + " wins!"
    else
      "Goddamn draw."
    end
  end

#  def vote_for(animal_id)
#    if animal_id.to_i == animal_1_id
#      self.increment! :animal_1_vote
#    elsif animal_id.to_i == animal_2_id
#      self.increment! :animal_2_vote
#    end
#  end

#  def declare_outcome
#    if self.animal_1_vote > self.animal_2_vote
#      self.animal_1.name + " wins!"
#    elsif self.animal_2_vote > self.animal_1_vote
#      self.animal_2.name " wins!"
#    else
#      "Goddamn draw."
#    end
#  end

end

# animal_1_vote and animal_2_vote as columns in battles.  they are invisible in views until the battle is closed.  need to figure out how to drop perishable cookie.  Once you click on a vote button then the button disappears. here in battle model there should be a method that kicks in when the battle is closed. this method compares animal_1_vote and animal_2_vote and declares a winner.  step 1 migration. step 2 button in battles show view.  step 3 button only shows in newest battle.  step 4.a button makes vote (method in battle model?).  step 4.b button drops cookie.  step 5 button greys out after vote.  step 6 figure out how to implement open/closed.  step 7 write vote comparison method.  step 8 figure out if winner/loser is a column.  step 9 display winner/loser stats in battles and animals
