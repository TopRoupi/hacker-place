import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "code", "codeparams", "stdinput", "programDialog" ]
  static values = {
    computerId: String,
    appId: String
  }

  connect() {
  }

  runScript() {
    this.dispatch("open", {
      detail: {
        app: "terminal",
        args: {
          code: this.codeTarget.value,
          args: this.codeparamsTarget.value
        }
      }
    })
  }

  disconnect() {
  }
}
