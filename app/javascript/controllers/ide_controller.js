import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "code", "codeparams", "stdinput", "programDialog" ]
  static values = {
    computerId: String,
    appId: String
  }

  connect() {
  }

  run_script() {
    // this.programDialogTarget.showModal()
    //
    console.log("run")
    this.dispatch("open", {
      detail: {
        app: "terminal",
        args: {
          code: this.codeTarget.value,
          args: this.codeparamsTarget.value
        }
      }
    })
    // console.log(this.codeparamsTarget.value)
    // this.deChannel.send({ command: "run", args: [this.codeTarget.value, this.codeparamsTarget.value] })
  }

  disconnect() {
  }
}
