require 'random_data'


standard_user_first = User.create!(
  email:    'standfirst@ex.com',
  password: 'password',
  role:     'standard'
)

5.times do
  User.create!(
    email:    RandomData.random_email,
    password: RandomData.random_sentence
  )
end

admin_user = User.create!(
  email:    'admin@ex.com',
  password: 'pw',
  role:     'admin'
)

premium_user = User.create!(
  email:    'premium@ex.com',
  password: 'pw',
  role:     'premium'
)

standard_user_last = User.create!(
  email:    'standlast@ex.com',
  password: 'pw',
  role:     'standard'
)

users = User.all



5.times do
  Wiki.create!(
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph,
    user:   users.sample
  )
end

public_wiki = Wiki.create!(
  title:    'This is a public wiki',
  body:     RandomData.random_paragraph,
  user:     users.sample,
  private:  false
)

private_wiki_by_standard_user_first = Wiki.create!(
  title:    'This is a private wiki by standard_user_first',
  body:     RandomData.random_paragraph,
  user:     User.first,
  private:  true
)

private_wiki_by_standard_user_last = Wiki.create!(
  title:    'This is a private wiki by standard_user_last',
  body:     RandomData.random_paragraph,
  user:     User.last,
  private:  true
)

wikis = Wiki.all


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
