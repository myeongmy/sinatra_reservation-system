# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@name = ["심명진","조성현","김준엽","이진영"]

emails = ["a.naver.com","b.naver.com"]
for i in 1..12
   Host.create(name: "#{i}번째 사람", email: "mail#{i}@naver.com",
              password: "123", password_confirmation: "123")
   Reservation.create(name: @name.sample(1),password:"pwd",day: "#{i}/31",time: "#{i}:00")   
end

    