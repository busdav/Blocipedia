require 'faker'


standard_user_first = User.create!(
  email:    'standfirst@example.com',
  password: 'password'
)

5.times do
  User.create!(
    email:    Faker::Internet.email,
    password: 'password'
  )
end

admin_user = User.create!(
  email:    'admin@example.com',
  password: 'password',
  role:     'admin'
)

premium_user = User.create!(
  email:    'premium@example.com',
  password: 'password',
  role:     'premium'
)

standard_user_last = User.create!(
  email:    'standlast@example.com',
  password: 'password'
)

users = User.all



15.times do
  Wiki.create!(
    title:  Faker::Seinfeld.quote,
    body:   Faker::Lorem.paragraph(20, false, 0),
    user_id:   users.sample.id
  )
end

public_wiki = Wiki.create!(
  title:    'This is a public wiki',
  body:     Faker::Lorem.paragraph(20, false, 0),
  user_id:     users.sample.id,
)

private_wiki_by_standard_user_first = Wiki.create!(
  title:    'This is a private wiki by standard_user_first',
  body:    Faker::Lorem.paragraph(20, false, 0),
  user_id:     User.first.id,
  private:  true
)

private_wiki_by_standard_user_last = Wiki.create!(
  title:    'This is a private wiki by standard_user_last',
  body:     Faker::Lorem.paragraph(20, false, 0),
  user_id:     User.last.id,
  private:  true
)

wikis = Wiki.all


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
