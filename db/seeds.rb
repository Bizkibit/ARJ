# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Event.destroy_all
Application.destroy_all
Organization.destroy_all
User.destroy_all


19.times do
  User.create({ first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                username: Faker::Internet.user_name,
                email: Faker::Internet.email,
                dob: Time.now - rand(16..40).years-rand(0..364).days,
                password: 'pass123',
                bio: Faker::Lorem.paragraph
              })
end

ADRESSES = [  "3894 Commercial St, Vancouver, BC V5N 4G2",
              "3077 Granville St #204, Vancouver, BC V6H 3J9",
              "1880 Renfrew St, Vancouver, BC V5M 3H9",
              "2455 E Broadway, Vancouver, BC V5M 1Y1",
              "2526 Waverley Ave, Vancouver, BC V5S 4W1",
              "7850 Champlain Cres, Vancouver, BC V5S 4C7",
              "900 W 12th Ave, Vancouver, BC V5Z 1N3",
              "725 Inglewood Ave, West Vancouver, BC V7T 1X5",
              "1090 W Georgia St, Vancouver, BC V6E 3V7",
              "852 Seymour St, Vancouver, BC V6B 3L6",
              "4505 Valley Dr, Vancouver, BC V6L 2L1",
              "555 Carrall St, Vancouver, BC V6B 2J8",
              "142 W Hastings St, Vancouver, BC V6B 1G8"
]

users = User.all

ADRESSES.each do |address|
  Organization.create(  name: Faker::Company.name+" Care",
                        address: address,
                        website: 'http://www.example.com',
                        phone: Faker::PhoneNumber.phone_number,
                        additional: Faker::Lorem.paragraph + "\n" + "Please specify your availablity",
                        user: users.sample,
                        aasm_state: ['pending', 'approved'].sample
                      )
end

organizations = Organization.all
approved_organizations = Organization.where(aasm_state: 'approved')

approved_organizations.each do |o|
  rand(1..5).times do
    Application.create( user: users.sample,
                        organization: o,
                        aasm_state: ['pending','approved'].sample,
                        detail: Faker::Lorem.paragraph
                      )
  end
  rand(1..3).times do
    Event.create({    start_date: Time.now + rand(0..60).days,
      end_date: Time.now + rand(2..6).months,
      spots: rand(4..10),
      organization: o,
      details: Faker::Lorem.paragraph})
  end
end

events = Event.all




puts 'Done!'
