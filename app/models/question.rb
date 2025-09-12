# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  heading       :string
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  qualtrics_id  :integer
#  salesforce_id :integer
#  survey_id     :integer
#
class Question < ApplicationRecord
  belongs_to :survey, required: true, class_name: "Survey", foreign_key: "survey_id"
  has_many  :answers, class_name: "Answer", foreign_key: "question_id", dependent: :destroy
end
