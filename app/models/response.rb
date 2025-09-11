class Response < ApplicationRecord
  belongs_to :survey, required: true, class_name: "Survey", foreign_key: "survey_id"
  belongs_to :uploader, required: true, class_name: "User", foreign_key: "uploader_id"
  has_many  :answers, class_name: "Answer", foreign_key: "response_id", dependent: :destroy
end
