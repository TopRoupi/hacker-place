class Desktop::AppComponent < ApplicationComponent
  def initialize(app:, id:)
    @app = app
    @id = id
  end

  def template
    div(id: @id) do
      case @app
      when "terminal"
        render(TerminalComponent.new)
      when "files"
        render(FileExplorerComponent.new(Computer.last))
      end
    end
  end
end
