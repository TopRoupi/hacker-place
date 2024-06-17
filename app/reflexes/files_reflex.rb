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
end
