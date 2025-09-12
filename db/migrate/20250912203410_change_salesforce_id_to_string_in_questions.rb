class ChangeSalesforceIdToStringInQuestions < ActiveRecord::Migration[8.0]
  def change
    change_column :questions, :salesforce_id, :string
  end
end
