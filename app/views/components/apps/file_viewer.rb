class Apps::FileViewer < ApplicationComponent
  attr_reader :app, :app_id

  def initialize(machine_id:, app_id: nil, args: {})
    @machine = Machine.find(machine_id)
    @app_id = app_id || "app-#{SecureRandom.hex}"
    @name = args["name"]
    @content = args["content"]
    @app = @name
  end

  def view_template
    div(class: "h-full", data_controller: "responsive-box") {
      pre(
        class: "absolute overflow-scroll",
        data_responsive_box_target: "el"
      ) { @content }
      div(
        class: "h-full",
        data_responsive_box_target: "shadowEl"
      ) {}
    }
  end
end
