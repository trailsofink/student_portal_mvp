ActiveSupport.on_load(:active_record) do
  SolidCache::Record.connects_to database: { writing: :primary, reading: :primary }
  SolidQueue::Record.connects_to database: { writing: :primary, reading: :primary }
  SolidCable::Record.connects_to database: { writing: :primary, reading: :primary }
end