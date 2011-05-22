class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :image

  has_attached_file :image, PAPERCLIP_STORAGE_OPTIONS.merge(
    :styles => { 
      :medium => "300x300>",
      :thumb => "100x100>"
    }
  )

  has_many :votes
  has_many :stories

  validates_presence_of :username 
  validates_length_of :username, :in => 3..30
  validates_format_of :username, :with => /^[\w.]*$/
  validates_presence_of :email
  validates_length_of :signature_quote, :maximum => 400
 
end
