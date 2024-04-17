import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "code", "codeparams", "stdinput", "programDialog" ]
  static values = {
    computerId: String,
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

  disconnect() {
  }
}
