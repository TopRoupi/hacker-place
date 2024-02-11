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
      },
      class: "h-full flex flex-col"
    ) do
      code_editor
      ide_bottom_nav

      program_dialog
    end
  end

  def program_dialog
    dialog(
      id: "#{@app_id}-program-dialog",
      class: "modal",
      data_ide_target: "programDialog"
    ) do
      div(class: "modal-box w-11/12 max-w-5xl bg-accent") do
        form(method: "dialog") do
          button(
            class: "btn btn-sm btn-circle btn-ghost absolute right-2 top-2"
          ) { "✕" }
        end
        div(
          class: "bg-black h-[300px] overflow-scroll"
        ) {
          pre(id: "#{@app_id}-run_stdout")
        }

        div(id: "#{@app_id}-stdin_status")
        div(
          class: "flex mt-2"
        ) {
          text_field(
            :run,
            :stdin,
            id: "#{@app_id}-run-stdin-input",
            class: "input input-bordered input-sm w-full max-w-xs",
            disabled: true,
            data: {
              ide_target: "stdinput"
            }
          )
          button(
            id: "#{@app_id}-run_stdin_btn",
            class: "btn btn-sm btn-ghost ml-auto",
            data_action: " click->ide#send_input",
            disabled: true
          ) { "send input" }
        }
      end
    end
  end

  def code_editor
    div(
      data_controller: "code-editor",
      data_code_editor_language_value: "lua",
      class: "grow"
    ) {
      textarea(data_code_editor_target: "editor", data_ide_target: "code")
    }
  end

  def ide_bottom_nav
    div(
      class: "flex mt-2 items-center"
    ) {
      label(for: "code_params") { "params: " }
      text_field(
        :code, :params,
        class: "input input-bordered input-sm w-full max-w-xs ml-2",
        data: {ide_target: "codeparams"}
      )

      button(
        class: "ml-auto btn btn-sm btn-primary",
        data_action: " click->ide#run_script"
      ) { "run" }
    }
  end
end
