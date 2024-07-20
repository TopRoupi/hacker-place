import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static outlets = [ "de" ]
  static values = {
    name: String,
    content: String,
    appId: String,
    fileId: String,
    machineId: String
  }

  connect() {
    this.deController = this.application.getControllerForElementAndIdentifier(this.deOutlet.element, 'de')
    super.connect()
  }

  openFileViewer(e) {
    this.deController.open({
      app: "file",
      args: {
        name: this.nameValue,
        content: this.contentValue
      }
    })
  }

  deleteFile(e) {
    this.stimulate("FilesReflex#delete_file", {
      fileId: this.fileIdValue,
      appId: this.appIdValue
    })
  }

  runFile(e) {
    this.deController.open({
      app: "terminal",
      args: {
        code: this.contentValue,
        args: ""
      }
    })
  }
}
