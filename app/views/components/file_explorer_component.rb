class FileExplorerComponent < ApplicationComponent
  def initialize(computer)
    @computer = computer
  end

  def template
    div(class: "flex rounded-t bg-base-200 py-2 px-4 mt-4 border-b border-base-100 items-center") do
      span { "Files" }

      button(class: "ml-auto bg-error text-error-content p-2 rounded-full w-5 h-5")
    end
    div(class: "rounded-b p-4 bg-base-200") do
      @computer.v_files.each do |f|
        span { f.inspect }
      end
    end
  end
end
