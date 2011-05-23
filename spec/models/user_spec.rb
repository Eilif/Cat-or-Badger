require 'spec_helper'

describe User do

  it 'can have username' do
    @user = User.create!(:username => "Dagon", :email => "ia_ia@cthulu.fhtagn", :password => 'secret')
    @user.username.should eq("Dagon")
  end

  it 'must have username' do
    @user = User.new(:email => "ia_ia@cthulu.fhtagn", :username => "")
    @user.should_not be_valid
    @user.should have(2).error_on(:username)
  end

  it 'must have username between 3 and 30 characters inclusive' do
    @user = User.new(:email => "Azathoth@cosmic_center.net",
      :username => "wayfuckingtoolongbecauseazathothisanidiotandknowsnorestraint")
    @user.should_not be_valid
    @user.should have(1).error_on(:username)
  end

  it 'must not allow illegal characters in username' do
    @user = User.new(:username => "Ke$h@",
      :email =>"mighthorrify@eventheeldergods.com")
    @user.should_not be_valid
    @user.should have(1).error_on(:username)
  end

  it 'can have email' do
    @user = User.create!(:username => "sleepy", :email => "so_sleepy@need.caff", :password => 'secret')
    @user.email.should eq("so_sleepy@need.caff")
  end

  it 'must have email' do
    @user = User.new(:username => "Dagon", :email => "", :password => 'secret')
    @user.should_not be_valid
    @user.should have(1).error_on(:email)
  end

  it 'can have image' do
    @user = User.new(:username => "Gull_Man", :email => "smoothsailing@skies.org",
      :image => File.new(Rails.root + 'spec/fixtures/images/seagull.jpg'))
    @user.image.original_filename.should eq('seagull.jpg')
  end

  it 'can have bio' do
    @user = User.create(:username => "Gull_Man", :email => "sailing@skies.org",
      :image => File.new(Rails.root + 'spec/fixtures/images/seagull.jpg'),
      :bio => "a long story about the sea that should probably exceed string length to show that this is indeed a text field and functioning as such. But I'm no good at sussing character length and I think this needs must be miserably long to go past 255, which I think is the length limit for strings. Now I will be confident, having counted that with one more line, I will have exceeded the maximum that I believe I need to exceed.", 
      :signature_quote => "some stuff")
    @user.bio.should eq("a long story about the sea that should probably exceed string length to show that this is indeed a text field and functioning as such. But I'm no good at sussing character length and I think this needs must be miserably long to go past 255, which I think is the length limit for strings. Now I will be confident, having counted that with one more line, I will have exceeded the maximum that I believe I need to exceed.")
  end

  it 'can have signature quote' do
    @user = User.create(:username => "Gull_Man", :email => "sailing@skies.org",
      :image => File.new(Rails.root + 'spec/fixtures/images/seagull.jpg'),
      :bio => "a long story about the sea that should probably exceed string length to show that this is indeed a text field and functioning as such. But I'm no good at sussing character length and I think this needs must be miserably long to go past 255, which I think is the length limit for strings. Now I will be confident, having counted that with one more line, I will have exceeded the maximum that I believe I need to exceed.", 
      :signature_quote => "some stuff")
    @user.signature_quote.should eq("some stuff")
  end

  it 'must limit signature quote to less than 400 chara if it has one' do
    @user = User.new(:username => "Gull_Man", :email => "sailing@skies.org",
      :signature_quote => "a long story about the sea that should probably exceed string length to show that this is indeed a text field and functioning as such. But I'm no good at sussing character length and I think this needs must be miserably long to go past 255, which I think is the length limit for strings. Now I will be confident, having counted that with one more line, I will have exceeded the maximum that I believe I need to exceed. Now this makes no sense and needs to exceed 400 characters to test the limit on length of signature quote. Listening to Inquisition is the only thing softening this exercise at the moment. Dagon sounds like something small that I would keep in a shoebox in the back of my closet and feed caterpillers.")
    @user.should_not be_valid
    @user.should have(1).error_on(:signature_quote)
  end

end
