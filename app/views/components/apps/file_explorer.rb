class Apps::FileExplorer < ApplicationComponent
  include Phlex::Rails::Helpers::ContentTag
  include Phlex::Rails::Helpers::TextField
  include Phlex::Rails::Helpers::FormWith

  attr_reader :app, :app_id

  def initialize(computer_id:, app_id: nil, args: {})
    @computer = Computer.find(computer_id)
    @app_id = app_id || "app-#{SecureRandom.hex}"
    @app = :files
    @args = args.symbolize_keys
  end

  def view_template
    case @args
    in {portal: String}
      p { "file name" }
      form_with(url: "") { |f|
        f.hidden_field(
          :app_id, value: @app_id
        )
        f.hidden_field(
          :computer_id, value: @computer.id
        )
        f.hidden_field(
          :content, value: @args[:content]
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
    else
      explorer
    end
  end

  def explorer
    div(class: "h-full", data_controller: "responsive-box") {
      div(
        class: "absolute overflow-scroll",
        data_responsive_box_target: "el"
      ) {
        button(
          class: "btn",
          data_reflex: "click->FilesReflex#refresh",
          data_computer_id: @computer.id,
          data_app_id: @app_id
        ) {
          "refresh"
        }
        table(class: "table") {
          tbody {
            @computer.v_files.each { |f|
              tr(
                id: "#{@app_id}-file-#{f.id}",
                class: "hover",
                data: {
                  controller: "file",
                  file_name_value: f.name,
                  # TODO please make the file viewer lazy load the content
                  # this can cause lag
                  file_de_outlet: "#de",
                  file_content_value: f.content,
                  file_app_id_value: @app_id,
                  file_file_id_value: f.id,
                  file_computer_id_value: @computer.id,
                  action: "dblclick->file#openFileViewer"
                }
              ) {
                th(
                  class: "select-none"
                ) { f.name }
                th {
                  button(
                    class: "btn btn-sm ml-auto block",
                    data_action: "click->file#deleteFile"
                  ) {
                    "delete"
                  }
                }
              }
            }
          }
        }
      }
      div(
        class: "h-full",
        data_responsive_box_target: "shadowEl"
      ) {}
    }
  end
end
