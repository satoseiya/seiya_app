namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(company: "starbucks",
                 name: "boo",
                 email: "boo@boo.jp",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    admin = User.create!(company: "doutor",
                 name: "doo",
                 email: "doo@doo.jp",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    20.times do |n|
      company = "starbucks"
      name  = Faker::Name.name
      email = "boo#{n+1}@boo.jp"
      password  = "password"
      User.create!(company: company,
                   name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    99.times do |n|
      company = "doutor"
      name  = Faker::Name.name
      email = "doo#{n+1}@doo.jp"
      password  = "password"
      User.create!(company: company,
                   name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 30)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end