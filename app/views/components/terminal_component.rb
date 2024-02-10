class TerminalComponent < ApplicationComponent
  include Phlex::Rails::Helpers::TextArea
  include Phlex::Rails::Helpers::TextField

  def initialize(computer_id:, app_id:)
    @computer_id = computer_id
    @app_id = app_id
  end

  def template
    div(
      data: {
        controller: "terminal",
        terminal_computer_id_value: @computer_id,
        terminal_app_id_value: @app_id
      }
    ) do
      p do
        plain " params "
        text_field(:code, :params, data: {terminal_target: "codeparams"})
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
      pre(id: "#{@app_id}-run_stdout")
      plain "---------------------- "
      br
      div(id: "#{@app_id}-stdin_status")
      text_field(
        :run,
        :stdin,
        id: "#{@app_id}-run-stdin-input",
        disabled: true,
        data: {
          terminal_target: "stdinput"
        }
      )
      button(
        id: "#{@app_id}-run_stdin_btn",
        data_action: " click->terminal#send_input",
        disabled: true
      ) { "send input" }
    end
  end
end
