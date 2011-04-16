class Battle < ActiveRecord::Base

  has_many :contentions, :dependent => :destroy
  has_many :animals, :through => :contentions

  validates_size_of :contentions, :is => 2

  def animal_names=(animal_names)
    animal_names.each do |name|
      animal = Animal.find_by_name(name)
      contentions.build(:animal => animal, :battle => self)
    end
  end

end
