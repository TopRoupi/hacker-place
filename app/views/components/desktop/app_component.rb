class Desktop::AppComponent < ApplicationComponent
  def initialize(app:, id:)
    @app = app
    @id = id

    @components_map = {
      "terminal" => TerminalComponent.new,
      "files" => FileExplorerComponent.new(Computer.last)
    }

    @app_component = @components_map[@app]
  end

  def template
    div(id: @id, class: "p-4 flex-1 flex flex-col") {
      div(class: "flex rounded-t bg-base-200 py-2 px-4 border-b border-base-100 items-center") {
        span { @app }
        button(
          class: "ml-auto bg-error text-error-content p-2 rounded-full w-5 h-5",
          data_id: @id,
          data_reflex: "click->DesktopReflex#close"
        )
      }
      div(class: "rounded-b p-4 bg-base-200 flex-1") {
        render(@app_component)
      }
    }
  end
end
