# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
#require 'factories'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
end

def valid_user_eilif
  @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
  @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
  user = User.create!(:username => "eilif", :email => "eilif@email.org",
  :image => @file, :bio => "Lots of text that I don't want to write",
  :signature_quote => "I feel empty.")
  user.save!
  user
end

def invalid_user
end

def valid_battle
  battle = Battle.create!(:animal_1 => valid_animal_susi, :animal_2 =>
  valid_animal_lokki, :blurb => "it's a given")
  battle.save!
  battle
end

def invalid_battle
end

def valid_animal_lokki
  @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
  @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
  lokki = Animal.create!(:name => "Lokki", :image => @file)
  lokki.save!
  lokki
end

def valid_animal_susi
  @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
  @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
  susi = Animal.create!(:name => "Susi-Ihminen", :image => @file)
  susi.save!
  susi
end

def valid_animal_koira
  @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
  @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
  koira = Animal.create!(:name => "KarhuKoira", :image => @file)
  koira.save!
  koira
end

def invalid_animal
end

def valid_story
  story = Story.new(:story_text => "Koira should win. That is all.", :user => 
  valid_user_eilif, :title => "Thoughts on a Fight", :battle => valid_battle)
  story.save!
  story
end

def invalid_story
end
