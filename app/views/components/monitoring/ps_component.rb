# frozen_string_literal: true

module Monitoring
  class PsComponent < ApplicationComponent
    def initialize(ps_table)
      @zombie_count = 0
      @count = 0

      @processes = ps_table
        .reject { _1.name.nil? }
        .select { _1.name.include? "lgo" }

      @processes.each do |p|
        if p.state == "Z"
          @zombie_count += 1
        else
          @count += 1
        end
      end

      @processes.select! { _1.state != "Z" }
    end

    def view_template
      div(id: "ps-count") { "count: #{@count}, zombies: #{@zombie_count}"}
      table(class: "table") {
        tr {
          th { "pid" }
          th { "state" }
          th { "up time" }
          th { "start time" }
          th { "memory" }
          th { "cpu%" }
          th { "mem%" }
          th { "actions" }
        }
        @processes.each do |p|
          render(Monitoring::PsItemComponent.new(p))
        end
      }
    end
  end

  class PsItemComponent < ApplicationComponent
    include ActionView::Helpers::NumberHelper

    attr_reader :process
    def initialize(ps_struct)
      @process = ps_struct
    end

    def states = {
      "R": "running",
      "T": "stopped",
      "U": "Uninterruptible Sleep",
      "S": "Interruptable Sleep",
      "Z": "zombie"
    }

    def view_template
      tr {
        td { process.pid.to_s }
        td { (states[process.state.to_sym] || process.state) }
        td { time_spent_in_words(process.utime.to_i) }
        td { ps_time(process.pid.to_s) }
        td { number_to_human_size(process.rss.to_i * 1000).to_s }
        td { process.pctcpu.to_s }
        td { process.pctmem.to_s }
      }
    end

    private

    def ps_time(pid)
      `ps -eo pid,lstart`.split("\n").map do |l|
        [l.split(" ")[0], l.split(" ")[1...].join(" ")]
      end.to_h[pid]
    end

    # thanks stackoverflow
    def time_spent_in_words(seconds, params={})
      time_periods_shown = params[:time_periods_shown] || 3
      use_short_names = params[:use_short_names] || false

      return "0 seconds" if seconds < 1
      short_name = {:second => :sec, :minute => :min, :hour => :hr, :day => :day, :week => :wk, :year => :yr}
      [[60, :second], [60, :minute], [24, :hour], [7, :day], [52, :week], [1000, :year]].map{ |count, name|
        if seconds > 0
          seconds, n = seconds.divmod(count)
          name = short_name[name] if use_short_names
          "#{n.to_i} #{name}".pluralize(n.to_i) if n.to_i > 0
        end
      }.compact.last(time_periods_shown).reverse.join(' ')
    end
  end
end
