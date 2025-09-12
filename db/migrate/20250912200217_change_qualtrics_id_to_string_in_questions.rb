class ChangeQualtricsIdToStringInQuestions < ActiveRecord::Migration[8.0]
  def change
    change_column :questions, :qualtrics_id, :string
  end
end