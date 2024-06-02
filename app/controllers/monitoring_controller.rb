class MonitoringController < ApplicationController
  def scripts
    render Monitoring::ScriptsView.new()
  end
end
