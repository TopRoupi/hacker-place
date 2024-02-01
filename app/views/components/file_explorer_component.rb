class FileExplorerComponent < ApplicationComponent
  include Phlex::Rails::Helpers::ContentTag
  def initialize(computer)
    @computer = computer
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
