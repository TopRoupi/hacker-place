# frozen_string_literal: true

class MonitoringReflex < ApplicationReflex
  def load
    cable_ready.inner_html(
      selector: "#ps",
      html: "loading"
    ).broadcast

    cable_ready.inner_html(
      selector: "#ps",
      html: render(Monitoring::PsComponent.new(Sys::ProcTable.ps(smaps: false)))
    ).broadcast

    morph :nothing
  end

  private

  def render_counter
    cable_ready.inner_html(
      selector: "#ps-count",
      html: "running: #{@running_count}, zombie: #{@zombie_count}"
    ).broadcast
  end
end
