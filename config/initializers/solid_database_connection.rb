ActiveSupport.on_load(:active_record) do
  if Rails.env.production?
    SolidCache::Record.connects_to database: { writing: :cache, reading: :cache }
    SolidQueue::Record.connects_to database: { writing: :queue, reading: :queue }
    SolidCable::Record.connects_to database: { writing: :cable, reading: :cable }
  else
    SolidCache::Record.connects_to database: { writing: :primary, reading: :primary }
    SolidQueue::Record.connects_to database: { writing: :primary, reading: :primary }
    SolidCable::Record.connects_to database: { writing: :primary, reading: :primary }
  end
end
