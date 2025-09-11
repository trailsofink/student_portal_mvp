class Answer < ApplicationRecord
  belongs_to :question, required: true, class_name: "Question", foreign_key: "question_id"
  belongs_to :response, required: true, class_name: "Response", foreign_key: "response_id"
end
