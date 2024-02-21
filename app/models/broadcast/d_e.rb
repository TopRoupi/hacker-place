module Broadcast
  class DE
    include Rails.application.routes.url_helpers
    include ActionView::RecordIdentifier
    include CableReady::Broadcaster

    attr_reader :computer_id

    def initialize(computer_id)
      @computer_id = computer_id
    end

    def open_app(app_id)
      cable_ready[DEChannel]
        .console_log(
          message: "test"
        )
        .broadcast_to(computer_id)
    end

    def close_app(app_id)
    end
  end
end
