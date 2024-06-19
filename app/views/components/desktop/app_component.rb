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

  def view_template
    div(
      id: @app_id,
      class: "grow flex flex-col absolute shadow-[rgba(50,_50,_105,_0.15)_0px_2px_5px_0px,_rgba(0,_0,_0,_0.05)_0px_1px_1px_0px]",
      style: @container_style,
      data: {
        controller: "app-window",
        de_target: "desktopApp",
        app_window_de_outlet: "#de",
        action: "mousedown->app-window#focus",
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
      class: "flex rounded-t py-1 px-2 items-center bg-gradient-to-t from-stone-900 to-stone-800",
      data: {
        app_window_target: "titleBar",
        action: "mousedown->app-window#dragMouseDown mousemove@document->app-window#drag mouseup@document->app-window#closeDrag"
      }
    ) {
      span { @app }
      div(class: "ml-auto grid grid-cols-3 grid-rows-1 gap-1") {
        minimize_button
        maximize_button
        close_button
      }
    }
  end

  def minimize_button
    button(
      class: "ml-auto bg-gradient-to-t from-orange-900 hover:from-orange-800 hover:to-orange-900 to-orange-800 p-1 rounded-full w-4 h-4 border-solid border-1 border-black",
      data_id: @app_id,
      data_action: "click->app-window#minimize"
    )
  end

  def maximize_button
    button(
      class: "ml-auto bg-gradient-to-t from-green-900 hover:from-green-800 hover:to-green-900 to-green-800 p-1 rounded-full w-4 h-4 border-solid border-1 border-black",
      data_id: @app_id,
      data_action: "click->app-window#maximize"
    )
  end

  def close_button
    button(
      class: "ml-auto bg-gradient-to-t from-red-900 hover:from-red-800 hover:to-red-900 to-red-800 p-1 rounded-full w-4 h-4 border-solid border-1 border-black",
      data_id: @app_id,
      data_action: "click->app-window#close"
    )
  end

  def window_body
    div(
      class: "rounded-b p-4 bg-black/80 grow window-body",
      data_app_window_target: "window",
      data_action: "mousemove->app-window#checkResize mousemove@document->app-window#resetCursor mousemove@document->app-window#resize mousedown->app-window#startResize mouseup@document->app-window#stopResize"
    ) {
      render(@app_component)
    }
  end
end
