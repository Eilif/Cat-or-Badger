class Animal < ActiveRecord::Base

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_presence_of :name
  validates_attachment_presence :image

end
