class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.string :name
      t.integer :qualtrics_id
      t.integer :salesforce_id
      t.string :heading
      t.integer :survey_id

      t.timestamps
    end
  end
end
