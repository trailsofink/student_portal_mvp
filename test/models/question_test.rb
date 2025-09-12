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
require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
