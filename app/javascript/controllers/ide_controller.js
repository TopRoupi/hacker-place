import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "code", "codeparams", "stdinput", "programDialog" ]
  static values = {
    computerId: String,
    appId: String
  }

  connect() {
    this.ideChannel = this.application.consumer.subscriptions.create(
      {
        channel: "IdeChannel",
        computerId: this.computerIdValue,
        appId: this.appIdValue
      },
      {
        received (data) {
          if (data.cableReady) CableReady.perform(data.operations)
        }
      }
    )
  }

  send_input() {
    console.log("input")
    this.ideChannel.send({ command: "input", args: [this.stdinputTarget.value] })
  }

  run_script() {
    this.programDialogTarget.showModal()
    console.log("run")
    console.log(this.codeparamsTarget.value)
    this.ideChannel.send({ command: "run", args: [this.codeTarget.value, this.codeparamsTarget.value] })
  }

  disconnect() {
  }
}
