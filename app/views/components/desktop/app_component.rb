class Desktop::AppComponent < ApplicationComponent
  def initialize(app:, id:, component:)
    @app = app
    @id = id
    @app_component = component

    # @components_map = {
    #   "ide" => IdeComponent.new(computer_id: Computer.last.id, app_id: @id),
    #   "files" => FileExplorerComponent.new(Computer.last)
    # }
    #
    # Desktop::AppFactory.get_app_component(@app,)
  end

  def template
    div(
      id: @id,
      class: "p-4 grow flex flex-col absolute w-[300px]",
      data: {
        controller: "app-window"
      }
    ) {
      div(
        class: "flex rounded-t bg-base-200 py-2 px-4 border-b border-base-100 items-center",
        data_app_window_target: "titleBar",
        data_action: "mousedown->app-window#dragMouseDown mousemove@document->app-window#drag mouseup@document->app-window#closeDrag"
      ) {
        span { @app }
        button(
          class: "ml-auto bg-error text-error-content p-2 rounded-full w-5 h-5",
          data_id: @id,
          data_reflex: "click->DesktopReflex#close"
        )
      }
      div(class: "rounded-b p-4 bg-base-200 grow") {
        render(@app_component)
      }
    }
  end
end
