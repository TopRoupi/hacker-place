# frozen_string_literal: true

class Home::IndexView < ApplicationView
  include Phlex::Rails::Helpers::TextArea
  include Phlex::Rails::Helpers::TextField

  def template
    div(data_controller: "cable-from", data_cable_from_id_value: "test")

    div(data_controller: "terminal") do
      p do
        plain " params "
        text_field(:code, :params, data: { terminal_target: "codeparams" })
      end
      whitespace
      text_area(
        :code,
        :code,
        value: "print(\"2\")",
        data: {
          terminal_target: "code"
        }
      )
      whitespace
      button(data_action: " click->terminal#run_script") { "run" }
      hr
      plain " ----STDOUT---- "
      pre(id: "run_stdout")
      plain "---------------------- "
      br
      div(id: "stdin_status")
      whitespace
      text_field(
        :run,
        :stdin,
        disabled: true,
        data: {
          terminal_target: "stdinput"
        }
      )
      whitespace
      button(
        id: "run_stdin_btn",
        data_action: " click->terminal#send_input",
        disabled: true
      ) { "send input" }
    end
  end
end
