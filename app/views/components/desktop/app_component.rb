class Desktop::AppComponent < ApplicationComponent
  attr_reader :app, :app_id, :component

  def initialize(component:, width: 400, min_width: 300, height: 200, min_height: 200)
    @app = component.app
    @app_id = component.app_id
    @app_component = component
    @width = width
    @height = height
    @min_width = min_width
    @min_height = min_height

    @container_style = <<~EOS
      width: #{@width}px;
      min-width: #{@min_width}px;
      height: #{@height}px;
      min-height: #{@min_height}px;
    EOS
  end

  def template
    div(
      id: @app_id,
      class: "grow flex flex-col absolute hidden",
      style: @container_style,
      data: {
        controller: "app-window",
        de_target: "desktopApp",
        id: @app_id,
        name: @app
      }
    ) {
      header_bar
      window_body
    }
  end

  def header_bar
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
        data_id: @app_id,
        data_reflex: "click->DesktopReflex#close"
      )
    }
  end

  def window_body
    div(
      class: "rounded-b p-4 bg-base-200 grow",
      data_app_window_target: "window",
      data_action: "mousemove->app-window#checkResize mousemove@document->app-window#resetCursor mousemove@document->app-window#resize mousedown->app-window#startResize mouseup@document->app-window#stopResize"
    ) {
      render(@app_component)
    }
  end
end
