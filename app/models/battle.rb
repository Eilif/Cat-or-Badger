class Battle < ActiveRecord::Base

  has_many :contentions, :dependent => :destroy
  has_many :animals, :through => :contentions

  validates_size_of :contentions, :is => 2

  def animal_names=(animal_names)
    if animal_names.present?
      self.contentions.destroy_all
    end

    animal_names.each do |name|
      animal = Animal.find_by_name(name)
      self.contentions.build(:animal => animal, :battle => self)
    end
  end

  def contender1=(animal)
    self.contentions.build(:animal => animal, :battle => self)
  end

  def contender1
    self.animals.name.first
  end

  def contender2=(animal)
    self.contentions.build(:animal => animal, :battle => self)
  end

  def contender2
    self.animals.name.last
  end

end
