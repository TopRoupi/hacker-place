class Apps::FileExplorer < ApplicationComponent
  include Phlex::Rails::Helpers::ContentTag

  attr_reader :app, :app_id

  def initialize(computer_id:, app_id: nil, args: [])
    @computer = Computer.find(computer_id)
    @app_id = app_id || "app-#{SecureRandom.hex}"
    @app = :files
  end

  def view_template
    div(
      class: "grid grid-cols-4 gap-4"
    ) {
      @computer.v_files.each { |f|
        button(
          class: "bg-secondary p-2 rounded",
          data_action: "click->de#launchApp",
          data_app: "file",
          data_args: JSON.generate({name: f.name, content: f.content})
        ) {
          f.name
        }
      }
    }
  end
end
