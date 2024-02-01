class FileExplorerComponent < ApplicationComponent
  include Phlex::Rails::Helpers::ContentTag
  def initialize(computer)
    @computer = computer
  end

  def template
    div do
      div(class: "flex rounded-t bg-base-200 py-2 px-4 border-b border-base-100 items-center") do
        span { "Files" }

        button(class: "ml-auto bg-error text-error-content p-2 rounded-full w-5 h-5")
      end
      div(class: "grid grid-cols-4 gap-4 rounded-b p-4 bg-base-200") do
        @computer.v_files.each do |f|
          content_tag(:button, class: "bg-secondary p-2 rounded", onclick: "f#{f.id}.showModal()") do
            f.name
          end

          dialog(id: "f#{f.id}", class: "modal") do
            div(class: "modal-box") do
              p(class: "py-4") { f.content }
              div(class: "modal-action") do
                form(method: "dialog") do
                  button(class: "btn") { "Close" }
                end
              end
            end
          end
        end
      end
    end
  end
end
