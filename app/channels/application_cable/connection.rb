module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uuid

    rescue_from Exception, with: :handle_any_error

    def connect
      self.uuid = SecureRandom.urlsafe_base64
    end

    def handle_any_error(exception)
      Rails.logger.error "WebSocket error: #{exception.message}"
      Rails.logger.error exception.backtrace.join("\n")

      close
    end
  end
end
