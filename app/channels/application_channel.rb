class ApplicationChannel < ApplicationCable::Channel
  def subscribed
    stream_for params[:id]
    # stream_from "application-stream"
  end
end
