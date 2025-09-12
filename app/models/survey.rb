# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  program    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Survey < ApplicationRecord
  has_many  :responses, class_name: "Response", foreign_key: "survey_id", dependent: :destroy
  has_many  :questions, class_name: "Question", foreign_key: "survey_id", dependent: :destroy
end
