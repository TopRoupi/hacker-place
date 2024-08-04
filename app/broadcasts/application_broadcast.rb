class ApplicationBroadcast
  include Rails.application.routes.url_helpers
  include ActionView::RecordIdentifier
  include CableReady::Broadcaster

  def render(component)
    ApplicationController.render(component)
  end
end
