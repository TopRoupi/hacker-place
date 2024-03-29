class IdeComponent < ApplicationComponent
  include Phlex::Rails::Helpers::TextArea
  include Phlex::Rails::Helpers::TextField

  attr_reader :app, :app_id

  def initialize(computer_id:, app_id: nil, args: [])
    @computer_id = computer_id
    @app_id = app_id || "app-#{SecureRandom.hex}"
    @app = :ide
  end

  def template
    div(
      data: {
        controller: "ide",
        ide_computer_id_value: @computer_id,
        ide_app_id_value: @app_id
      },
      class: "h-full flex flex-col"
    ) do
      code_editor
      ide_bottom_nav
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
        data_action: " click->ide#runScript"
      ) { "run" }
    }
  end
end
