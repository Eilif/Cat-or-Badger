Factory.sequence(:email) {|n| "email#{n}@example.com" }

Factory.define :user do |u|
  u.username 'eilif'
  u.email { Factory.next :email }
  u.password 'secret'
  u.password_confirmation 'secret'
  u.bio "Lots of text that I don't want to write"
  u.signature_quote "I feel empty."
  u.image { File.new(Rails.root + 'spec/fixtures/images/seagull.jpg') }
end

Factory.define :susi, :class => Animal do |s|
  s.name 'Susi-Ihminen'
  s.image { File.new(Rails.root + 'spec/fixtures/images/seagull.jpg') }
end

Factory.define :lokki, :class => Animal do |l|
  l.name 'Lokki'
  l.image { File.new(Rails.root + 'spec/fixtures/images/seagull.jpg') }
end

Factory.define :koira, :class => Animal do |k|
  k.name 'KarhuKoira'
  k.image { File.new(Rails.root + 'spec/fixtures/images/seagull.jpg') }
end

Factory.define :battle do |b|
  b.blurb "it's a given"
  b.association :animal_1, :factory => :lokki
  b.association :animal_2, :factory => :susi
end

Factory.define :story do |s|
  s.story_text "Koira should win. That is all."
  s.title "it's a given"
  s.association :battle
  s.association :user
end
