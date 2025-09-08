class Question < ApplicationRecord
  belongs_to :survey, required: true, class_name: "Survey", foreign_key: "survey_id"
  has_many  :answers, class_name: "Answer", foreign_key: "question_id", dependent: :destroy
end
