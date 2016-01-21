# == Schema Information
#
# Table name: answer_choices
#
#  id            :integer          not null, primary key
#  response_text :text             not null
#  question_id   :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class AnswerChoice < ActiveRecord::Base
  validates :response_text, presence: true
  validates :question, presence: true

  belongs_to :question,
    foreign_key: :question_id,
    primary_key: :id,
    class_name: 'Question'

  has_many :responses,
    foreign_key: :answer_choice_id,
    primary_key: :id,
    class_name: 'Response'
end
