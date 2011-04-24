class Animal < ActiveRecord::Base

  has_attached_file :image, PAPERCLIP_STORAGE_OPTIONS.merge(
    :styles => { 
      :medium => "300x300>",
      :thumb => "100x100>"
    }
  )

  validates_presence_of :name
  validates_attachment_presence :image

  has_many :battles

end
