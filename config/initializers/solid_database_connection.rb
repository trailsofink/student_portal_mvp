Rails.application.config.to_prepare do
  SolidCache::Record.connects_to database: { writing: :primary, reading: :primary }
  SolidQueue::Record.connects_to database: { writing: :primary, reading: :primary }
  SolidCable::Record.connects_to database: { writing: :primary, reading: :primary }
end
