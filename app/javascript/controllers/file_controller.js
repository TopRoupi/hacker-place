import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static outlets = [ "de" ]
  static values = {
    name: String,
    content: String,
    appId: String,
    fileId: String,
    computerId: String
  }

  connect() {
    this.deController = this.application.getControllerForElementAndIdentifier(this.deOutlet.element, 'de')
    super.connect()
  }

  openFileViewer(e) {
    console.log(this.contentValue)
    this.deController.open({
      app: "file",
      args: {
        name: this.nameValue,
        content: this.contentValue
      }
    })
  }

  deleteFile(e) {
    console.log("delte")
    this.stimulate("FilesReflex#delete_file", {
      fileId: this.fileIdValue,
      appId: this.appIdValue
    })
  }
}
