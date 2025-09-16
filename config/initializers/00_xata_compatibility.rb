# Xata database compatibility
# Xata doesn't support CREATE EXTENSION statements but has plpgsql enabled by default
Rails.application.config.to_prepare do
  if ENV["DATABASE_URL"]&.include?("xata.sh")
    module XataExtensionPrevention
      def enable_extension(name, **)
        Rails.logger&.info "Skipping extension '#{name}' - Xata has it enabled by default"
      end
    end

    ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.prepend(XataExtensionPrevention)
  end
end