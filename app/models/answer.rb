# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  value       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#  response_id :integer
#
class Answer < ApplicationRecord
  belongs_to :question, required: true, class_name: "Question", foreign_key: "question_id"
  belongs_to :response, required: true, class_name: "Response", foreign_key: "response_id"
end
