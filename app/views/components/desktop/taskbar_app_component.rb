class Desktop::TaskbarAppComponent < ApplicationComponent
  def initialize(name:, app_id:)
    @name = name
    @app_id = app_id
  end

  def template
    button(
      id: @app_id + "-taskbar",
      data_id: @app_id,
      data_reflex: "click->DesktopReflex#focus",
      class: "p-2 bg-white/10"
    ) do
      @name
    end
  end
end
