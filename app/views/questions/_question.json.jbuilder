json.extract! question, :id, :name, :qualtrics_id, :salesforce_id, :heading, :survey_id, :created_at, :updated_at
json.url question_url(question, format: :json)
