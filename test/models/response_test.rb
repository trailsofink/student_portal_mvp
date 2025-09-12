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
require "test_helper"

class ResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
