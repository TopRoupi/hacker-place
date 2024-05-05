class Desktop::TaskbarAppComponent < ApplicationComponent
  def initialize(name:, app_id:)
    @name = name
    @app_id = app_id
  end

  def view_template
    button(
      id: @app_id + "-taskbar",
      data_app: @app_id,
      data_action: "click->taskbar#focus",
      class: "px-1 py-1 bg-white/10"
    ) do
      @name
    end
  end
end
