class AppLogger

  # Wrapper for all error logging calls.
  def self.error(error_class, error_message, exception = nil, notify_hb: true)
    if exception.present?
      Rails.logger.error(error_message)

      # Log entire stack trace.
      Rails.logger.error(exception.message)
      exception.backtrace.each { |line| Rails.logger.error(line) }

      # Autoinclude exception error message if not already included.
      if exception.message.present?
        unless error_message.include?(exception.message)
          error_message << ": #{exception.message}"
        end
      end

      # Honeybadger.notify(exception, error_class: error_class, error_message: error_message) if notify_hb
    else
      puts "!!!! #{error_class}\n  #{error_message}" if Rails.env.development?
      Rails.logger.error("ERROR: #{error_class}\n  #{error_message}")
      # Honeybadger.notify(error_class: error_class, error_message: error_message)
    end
  end
end
