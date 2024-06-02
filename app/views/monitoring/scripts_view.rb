# frozen_string_literal: true

class Monitoring::ScriptsView < ApplicationView
  def view_template
    button(data_reflex: "click->MonitoringReflex#load") { "reload" }

    div(id: "ps") {
      render(Monitoring::PsComponent.new(Sys::ProcTable.ps(smaps: false)))
    }
  end
end
