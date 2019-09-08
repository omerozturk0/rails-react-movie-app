# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rating.destroy_all
Movie.destroy_all
Category.destroy_all
User.destroy_all

User.create(
    full_name: 'Ömer Öztürk',
    email: 'omer.oztrk0@gmail.com',
    password: 123456
)

10.times do
  User.create(
      full_name: Faker::Name.unique.name,
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password
  )
end

10.times do
  Category.create(
      title: Faker::Lorem.unique.sentence(word_count: 1),
      description: Faker::Lorem.sentence(word_count: 5),
      active: Faker::Boolean.boolean(true_ratio: 0.8)
  )
end

100.times do
  Movie.create(
      title: Faker::Lorem.unique.sentence(word_count: 2),
      text: Faker::Lorem.sentence(word_count: 3),
      active: Faker::Boolean.boolean(true_ratio: 0.8),
      category: Category.all.shuffle[rand(0..9)],
      user: User.all.shuffle[rand(0..10)],
      image_url: Faker::LoremFlickr.image(size: "200x250", search_terms: ['movies']),
      created_at: Faker::Time.between(from: DateTime.now - 1.years, to: DateTime.now)
  )
end

200.times do
  Rating.create(
      movie: Movie.all.shuffle[rand(0..99)],
      user: User.all.shuffle[rand(0..10)],
      value: rand(1..5)
  )
end
