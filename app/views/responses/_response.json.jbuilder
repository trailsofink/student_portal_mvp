json.extract! response, :id, :survey_id, :uploader_id, :created_at, :updated_at
json.url response_url(response, format: :json)
