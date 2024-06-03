class MonitoringController < ApplicationController
  skip_before_action :authenticate

  def scripts
    render Monitoring::ScriptsView.new
  end
end
