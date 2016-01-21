# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  question_text :text
#  poll_id       :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Question < ActiveRecord::Base
  validates :poll_id, presence: true

  belongs_to :poll,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: 'Poll'

  has_many :answer_choices,
    foreign_key: :question_id,
    primary_key: :id,
    class_name: 'AnswerChoice'

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    id = self.id

    Question.find_by_sql(<<-SQL)
      SELECT
        answer_choices.response_text, COUNT(responses.user_id)
      FROM
        questions
        JOIN
        answer_choices ON questions.id = answer_choices.question_id
        JOIN
        responses ON answer_choices.id = responses.answer_choice_id
      WHERE
        questions.id = #{id}
      GROUP BY
        responses.answer_choice_id
    SQL
  end
end
