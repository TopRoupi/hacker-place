import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "code", "codeparams", "stdinput", "programDialog" ]
  static values = {
    machineId: String,
    appId: String
  }
  static outlets = [ "de" ]

  connect() {
    this.deController = this.application.getControllerForElementAndIdentifier(this.deOutlet.element, 'de')
  }

  runScript() {
    this.deController.open({
      app: "terminal",
      args: {
        code: this.codeTarget.editor.getValue(),
        args: this.codeparamsTarget.value
      }
    })
  }

  saveScript() {
    this.deController.open({
      app: "files",
      args: {
        portal: "create_file",
        path: "",
        content: this.codeTarget.editor.getValue(),
      }
    })
  }

  disconnect() {
  }
}
