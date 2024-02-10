class IdeComponent < ApplicationComponent
  include Phlex::Rails::Helpers::TextArea
  include Phlex::Rails::Helpers::TextField

  def initialize(computer_id:, app_id:)
    @computer_id = computer_id
    @app_id = app_id
  end

  def template
    div(
      data: {
        controller: "ide",
        ide: @computer_id,
        ide_app_id_value: @app_id
      }
    ) do
      p do
        plain " params "
        text_field(:code, :params, data: {ide_target: "codeparams"})
      end
      div(
        data_controller: "code-editor",
        data_code_editor_language_value: "lua"
      ) do
        textarea(data_code_editor_target: "editor", data_ide_target: "code")
      end
      button(data_action: " click->ide#run_script") { "run" }
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
          ide_target: "stdinput"
        }
      )
      button(
        id: "#{@app_id}-run_stdin_btn",
        data_action: " click->ide#send_input",
        disabled: true
      ) { "send input" }
    end
  end
end
