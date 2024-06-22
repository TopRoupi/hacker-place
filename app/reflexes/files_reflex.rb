# frozen_string_literal: true

class FilesReflex < ApplicationReflex
  def create_file
    file = VFile.new(computer_id: params["computer_id"], name: params["name"], content: params["content"])
    if !file.save
      morph "##{params["app_id"]} .errors", file.errors.to_a.inspect
    else
      cable_ready
        .dispatch_event(
          name: "close-app",
          detail: {
            appId: params["app_id"]
          }
        )
      morph :nothing
    end
  end

  def delete_file(args)
    VFile.find(args[:file_id]).delete

    cable_ready
      .remove(
        selector: "##{args[:app_id]}-file-#{args[:file_id]}"
      )
    morph :nothing
  end

  def refresh
    app_id = element.dataset[:app_id]
    computer_id = element.dataset[:computer_id]

    morph "##{app_id} .window-body", render(Apps::FileExplorer.new(app_id: app_id, computer_id: computer_id))
  end
end
