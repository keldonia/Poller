# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  selected         :boolean
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user, presence: true
  validates :answer_choice_id, presence: true
  validate :not_duplicate_response
  validate :author_cant_respond

  belongs_to :user,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'User'

  belongs_to :answer_choice,
    foreign_key: :answer_choice_id,
    primary_key: :id,
    class_name: 'AnswerChoice'

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :poll,
    through: :question,
    source: :poll

  def sibling_responses
    ques = self.question
    id = self.user_id
    response = ques.responses.where(user_id: id)

  end

  def respondent_already_answered?
    !self.sibling_responses.nil?
  end

  def not_duplicate_response
    if self.respondent_already_answered?
      errors[:response] << "Can't answer the same question twice."
    end
  end

  def author_cant_respond
    if self.question.poll.author_id == user_id
      errors[:response] << "Authors can't answer their own polls."
    end
  end
end
