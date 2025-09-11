class CreateResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :responses do |t|
      t.integer :survey_id
      t.integer :uploader_id

      t.timestamps
    end
  end
end
