# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = 10.times.map { |name| { user_name: Faker::Name.name}  }
users = User.create( names )

poll_names = (1..40).map { |i| { author_id: (i + 1 % 20), title: Faker::Book.title } }
polls = Poll.create( poll_names )

question_texts = 400.times.map { |question| { poll_id: (rand(40).to_i + 1), question_text: Faker::Hipster.paragraph } }
questions = Question.create( question_texts )

answer_choice_texts = 1600.times.map { |answer| { question_id: (rand(1600).to_i + 1), response_text: Faker::Hipster.sentence } }
answer_choices = AnswerChoice.create( answer_choice_texts )

response_choices = (1..10).each { |i| (1..1600).each { |j| Response.create( {user_id: (i + 1 % 20), answer_choice_id: j, selected: rand(2).to_i }) } }
