# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Poll < ActiveRecord::Base
  validates :author, presence: true
  validates :title, presence: true

  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: 'User'

  has_many :questions,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: 'Question'

  has_many :answer_choices,
    through: :questions,
    source: :answer_choices

  has_many :responses,
    through: :answer_choices,
    source: :responses
end
