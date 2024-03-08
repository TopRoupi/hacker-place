class FileExplorerComponent < ApplicationComponent
  include Phlex::Rails::Helpers::ContentTag

  attr_reader :app, :app_id

  def initialize(computer_id:, app_id: nil)
    @computer = Computer.find(computer_id)
    @app_id = app_id || "app-#{SecureRandom.hex}"
    @app = :files
  end

  def template
    div(class: "grid grid-cols-4 gap-4") {
      @computer.v_files.each { |f|
        content_tag(:button, class: "bg-secondary p-2 rounded", onclick: "f#{f.id}.showModal()") {
          f.name
        }
      }
    }
  end
end
