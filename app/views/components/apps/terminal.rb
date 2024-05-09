class Apps::Terminal < ApplicationComponent
  include Phlex::Rails::Helpers::TextArea
  include Phlex::Rails::Helpers::TextField

  attr_reader :app, :app_id

  def initialize(computer_id:, app_id: nil, args: [])
    @computer_id = computer_id
    @app_id = app_id || "app-#{SecureRandom.hex}"
    @app = :terminal
    @code, @args = args
  end

  def view_template
    div(
      class: "h-full flex flex-col",
      data: {
        controller: "terminal",
        terminal_computer_id_value: @computer_id,
        terminal_app_id_value: @app_id
      }
    ) do
      textarea(
        class: "hidden",
        data_terminal_target: "code"
      ) { @code }
      textarea(
        class: "hidden",
        data_terminal_target: "params"
      ) { @args }

      div(class: "h-full", data_controller: "responsive-box") {
        pre(
          id: "#{@app_id}-run_stdout",
          class: "absolute overflow-scroll",
          data_responsive_box_target: "el"
        )
        div(
          class: "h-full",
          data_responsive_box_target: "shadowEl"
        ) {}
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
            terminal_target: "stdinput"
          }
        )
        button(
          id: "#{@app_id}-run_stdin_btn",
          class: "btn btn-sm btn-ghost ml-auto",
          data_action: " click->terminal#send_input",
          disabled: true
        ) { "send input" }
      }
    end
  end
end
