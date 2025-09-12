# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  survey_id   :integer
#  unique_id   :string
#  uploader_id :integer
#
class Response < ApplicationRecord
  belongs_to :survey, required: true, class_name: "Survey", foreign_key: "survey_id"
  belongs_to :uploader, required: true, class_name: "User", foreign_key: "uploader_id"
  has_many  :answers, class_name: "Answer", foreign_key: "response_id", dependent: :destroy

  def fullname
    first_name = answers.joins(:question).find_by(questions: { name: 'QID1_TEXT' })&.value
    last_name = answers.joins(:question).find_by(questions: { name: 'QID2_TEXT' })&.value

    fullname = first_name + ' ' + last_name
    fullname
  end

  def program
    program = Survey.find_by(id: self.survey_id).program
  end

  def date
    date = answers.joins(:question).find_by(questions: { name: 'recordedDate'})&.value
    date
  end
end
