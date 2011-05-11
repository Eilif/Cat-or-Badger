class Battle < ActiveRecord::Base

  belongs_to :animal_1, :class_name => "Animal"
  belongs_to :animal_2, :class_name => "Animal"

  validates_presence_of :animal_1
  validates_presence_of :animal_2

  has_many :votes
  has_many :stories

  def tally_animal(animal)
    self.votes.sum(:weight, :conditions => { :animal_id => animal.id })
  end

  def tally_animal_1
    tally_animal(animal_1)
  end

  def tally_animal_2
    tally_animal(animal_2)
  end

  def declare_outcome
    if tally_animal_1 > tally_animal_2
      self.animal_1.name + " wins!"
    elsif tally_animal_2 > tally_animal_1
      self.animal_2.name + " wins!"
    else
      "Goddamn draw."
    end
  end

end

# animal_1_vote and animal_2_vote as columns in battles.  they are invisible in views until the battle is closed.  need to figure out how to drop perishable cookie.  Once you click on a vote button then the button disappears. here in battle model there should be a method that kicks in when the battle is closed. this method compares animal_1_vote and animal_2_vote and declares a winner.  step 1 migration. step 2 button in battles show view.  step 3 button only shows in newest battle.  step 4.a button makes vote (method in battle model?).  step 4.b button drops cookie.  step 5 button greys out after vote.  step 6 figure out how to implement open/closed.  step 7 write vote comparison method.  step 8 figure out if winner/loser is a column.  step 9 display winner/loser stats in battles and animals
