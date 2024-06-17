class Apps::FileExplorer < ApplicationComponent
  include Phlex::Rails::Helpers::ContentTag
  include Phlex::Rails::Helpers::TextField
  include Phlex::Rails::Helpers::FormWith

  attr_reader :app, :app_id

  def initialize(computer_id:, app_id: nil, args: {})
    @computer = Computer.find(computer_id)
    @app_id = app_id || "app-#{SecureRandom.hex}"
    @app = :files
    @args = args
    puts args
  end

  def view_template
    case @args["portal"]
    when nil
      explorer
    when "create_file"
      p { "file name" }
      form_with(url: "") { |f|
        f.hidden_field(
          :app_id, value: @app_id
        )
        f.hidden_field(
          :computer_id, value: @computer.id
        )
        f.hidden_field(
          :content, value: @args["content"]
        )
        f.text_field(
          :name,
          class: "input input-bordered input-sm w-full"
        )
        button(
          class: "ml-auto btn btn-sm btn-primary",
          data_reflex: "click->FilesReflex#create_file",
          data_reflex_serialize_form: true
        ) { "save" }
      }
      p(class: "errors") { "" }
    end
  end

  def explorer
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
