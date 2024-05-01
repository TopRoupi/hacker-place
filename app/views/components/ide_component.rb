class IdeComponent < ApplicationComponent
  include Phlex::Rails::Helpers::TextArea
  include Phlex::Rails::Helpers::TextField

  attr_reader :app, :app_id

  def initialize(computer_id:, app_id: nil, args: [])
    @computer_id = computer_id
    @app_id = app_id || "app-#{SecureRandom.hex}"
    @app = :ide
  end

  def view_template
    div(
      data: {
        controller: "ide",
        ide_computer_id_value: @computer_id,
        ide_app_id_value: @app_id,
        ide_de_outlet: "#de"
      },
      class: "h-full flex flex-col"
    ) do
      code_editor
      ide_bottom_nav
    end
  end

  def code_editor
    div(class: "grow flex", data_controller: "responsive-box") {
      div(
        class: "absolute",
        data_controller: "monaco",
        data_responsive_box_target: "el",
        data_ide_target: "code"
      ) {}
      div(
        class: "grow",
        data_responsive_box_target: "shadowEl"
      ) {}
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
