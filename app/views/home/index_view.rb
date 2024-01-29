# frozen_string_literal: true

class Home::IndexView < ApplicationView
  include Phlex::Rails::Helpers::TextArea
  include Phlex::Rails::Helpers::TextField

  def initialize(computer:)
    @computer = computer
  end

  def template
    render FileExplorerComponent.new(@computer)
    div(data_controller: "cable-from", data_cable_from_id_value: "test")


    div(data_controller: "terminal") do
      p do
        plain " params "
        text_field(:code, :params, data: { terminal_target: "codeparams" })
      end
      div(
        data_controller: "code-editor",
        data_code_editor_language_value: "lua"
      ) do
        textarea(data_code_editor_target: "editor", data_terminal_target: "code")
      end
      button(data_action: " click->terminal#run_script") { "run" }
      hr
      plain " ----STDOUT---- "
      pre(id: "run_stdout")
      plain "---------------------- "
      br
      div(id: "stdin_status")
      text_field(
        :run,
        :stdin,
        disabled: true,
        data: {
          terminal_target: "stdinput"
        }
      )
      button(
        id: "run_stdin_btn",
        data_action: " click->terminal#send_input",
        disabled: true
      ) { "send input" }
    end
  end
end
