class User < ActiveRecord::Base

  has_attached_file :image, PAPERCLIP_STORAGE_OPTIONS.merge(
    :styles => { 
      :medium => "300x300>",
      :thumb => "100x100>"
    }
  )

  validates_presence_of :username 
#  validates_length_of :username, :in => 3..30
#  validates_format_of :username, :with => /^[/w.]*$/
  validates_presence_of :email
  
end

#user has username, email, password, password_verification, avatar, signature_quote, bio
