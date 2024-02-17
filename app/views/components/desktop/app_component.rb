class Desktop::AppComponent < ApplicationComponent
  def initialize(app:, id:, component:)
    @app = app
    @id = id
    @app_component = component
  end

  def template
    div(
      id: @id,
      class: "grow flex flex-col absolute w-[300px]",
      data: {
        controller: "app-window"
      }
    ) {
      div(
        class: "flex rounded-t bg-base-200 py-2 px-4 border-b border-base-100 items-center",
        data: {
          app_window_target: "titleBar",
          action: "mousedown->app-window#dragMouseDown mousemove@document->app-window#drag mouseup@document->app-window#closeDrag"
        }
      ) {
        span { @app }
        button(
          class: "ml-auto bg-error text-error-content p-2 rounded-full w-5 h-5",
          data_id: @id,
          data_reflex: "click->DesktopReflex#close"
        )
      }
      div(
        class: "rounded-b p-4 bg-base-200 grow",
        data_app_window_target: "window",
        data_action: "mousemove->app-window#checkResize mousemove@document->app-window#resetCursor mousemove@document->app-window#resize mousedown->app-window#startResize mouseup@document->app-window#stopResize"
      ) {
        render(@app_component)
      }
    }
  end
end
