# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

schools = ActiveSupport::JSON.decode(File.read('db/seeds/schools.json'))
subject_areas = ActiveSupport::JSON.decode(File.read('db/seeds/subject_areas.json'))
cities = CSV.read('db/seeds/aus_cities.csv')

schools['schools'].each do |school|
  School.create name: school['name']
end
p "schools populated"

cities.each do |row|
  if row[0].present?
    City.create name: row[0], state: row[1]
  end
end
p "cities populated"

subject_areas['areas'].each do |area|
  SubjectArea.create name: area['name']
end
p "subject areas populated"

if Rails.env.development?
  if user = User.find_by_email('user@example.com')
    user.profile.delete if user.profile.present?
    user.delete
  end
  User.create email: "user@example.com", password: "heysenior", name: "Example User", role: "student"
  p 'example user created'
end